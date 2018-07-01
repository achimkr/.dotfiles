import requests
import argparse
import pathlib
import logging
from bs4 import BeautifulSoup

logging.basicConfig(format='%(asctime)s - %(levelname)s - %(message)s',
                    level=logging.INFO)
logger = logging.getLogger(__name__)

class IliasDownloader:

    def __init__(self):
        self.args = self.get_args()
        self.session = requests.session()
        self.login(self.args.username, self.args.password)

    def login(self, username, password):
        logger.info("Logging in...")
        payload = {"sendLogin": 1,
                   "idp_selection": "https://idp.scc.kit.edu/idp/shibboleth",
                   "target": "https://ilias.studium.kit.edu/shib_login.php",
                   "home_organization_selection": "Mit KIT-Account anmelden"}
        response = self.session.post(
            "https://ilias.studium.kit.edu/Shibboleth.sso/Login",
            data=payload)

        soup = BeautifulSoup(response.text, 'html.parser')
        form = soup.find('form', attrs={'class': 'form2', 'method': 'post'})
        action = form['action']

        # parse and login
        credentials = {"_eventId_proceed": "", "j_username": username, "j_password": password}
        url = "https://idp.scc.kit.edu" + action

        response = self.session.post(url, data=credentials)

        html_doc = response.text
        soup = BeautifulSoup(html_doc, 'html.parser')
        relay_state = soup.find('input', attrs={'name': 'RelayState'})
        saml_response = soup.find('input', attrs={'name': 'SAMLResponse'})

        if not relay_state:
            raise Exception('wrong credentials!')

        payload = {'RelayState': relay_state['value'],
                   'SAMLResponse': saml_response['value'],
                   '_eventId_proceed': ''}
        dashboard_html = self.session.post(
            "https://ilias.studium.kit.edu/Shibboleth.sso/SAML2/POST",
            data=payload).text
        logger.info("Logged in successfully")
        return BeautifulSoup(dashboard_html, 'html.parser')

    def get_args(self):
        parser = argparse.ArgumentParser(description="Download all linked files from Ilias")
        parser.add_argument("username", help="Ilias username")
        parser.add_argument("password", help="Ilias password")
        parser.add_argument("dir", help="Directory to save files to")
        parser.add_argument("url", help="url to scrape")
        return parser.parse_args()

    def get_landing_page(self):
        r = self.session.get(self.args.url)
        r = self.session.get(self.args.url)
        with open("debug.html", "w") as f:
            f.write(r.text)
        return r.text

    def extract_urls(self, text):
        soup = BeautifulSoup(text, "html.parser")
        urls = soup.find_all("a", attrs={"class": "il_ContainerItemTitle"})
        urls = list(map(lambda x: x.get("href"), urls))
        return urls

    def download(self):
        logger.info("Starting download...")
        text = self.get_landing_page()
        logger.info("Parsing urls...")
        urls = self.extract_urls(text)
        logger.info("Parsing done. Found {} urls.".format(len(urls)))
        for url in urls:
            logger.info("Url: {}".format(url))
        for url in urls:
            logger.debug("URL: " + url)
            r = self.session.head(url)
            filepath = pathlib.Path(self.args.dir).joinpath(r.headers.get("Content-Description"))
            logger.info("Handling file: {}".format(r.headers.get("Content-Description")))
            if filepath.exists():
                if filepath.stat().st_size == int(r.headers["content-length"]):
                    logger.info("File already exists. Skipping...")
                    continue
                else:
                    logger.info("File size difference found: Local: {}, Remote: {}".format(filepath.stat().st_size,
                                                                                     r.headers["content-length"]))
            logger.info("Downloading file...")
            r = self.session.get(url)
            if r.status_code == 200:
                with filepath.open("wb") as fd:
                    for chunk in r.iter_content(chunk_size=128):
                        fd.write(chunk)
                logger.info("File downloaded successfully!")
            else:
                logger.error("Error while downloading file: " + r)

if __name__ == '__main__':
    downloader = IliasDownloader()
    downloader.download()

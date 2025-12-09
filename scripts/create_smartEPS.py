from __future__ import print_function

import time
import requests
from pprint import pprint
import pandas as pd
import json
from datetime import datetime

host = "http://localhost:8080"


newproject_url = f"{host}/api/rest/projects?name=smartEPS1" 
requests.post(newproject_url)
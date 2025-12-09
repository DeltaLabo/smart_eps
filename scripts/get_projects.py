from __future__ import print_function

import time
import requests
from pprint import pprint
import pandas as pd
import json
from datetime import datetime

host = "http://localhost:8080"

projects_url = f"{host}/api/rest/projects" 
projects_response = requests.get(projects_url)

if projects_response.status_code == 200:
    projects = projects_response.json()
    projects_data = list(map(lambda b: {'Project Name':b['name'], 'Project ID':b['id']}, projects))
    df = pd.DataFrame.from_records(projects_data)
    print(df)
else:
    pprint("Problem in fetching projects")
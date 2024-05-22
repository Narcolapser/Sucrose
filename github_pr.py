import os
import requests
import datetime
import json

# Get GitHub API token from environment variable
GITHUB_API_TOKEN = os.getenv("GITHUB_API")
HA_AUTHORITY = os.getenv("HA_AUTHORITY")
if not GITHUB_API_TOKEN:
    raise EnvironmentError("Please set the GITHUB_API environment variable")

# Define the GitHub API URL
GITHUB_API_URL = "https://api.github.com"
USERNAME = 'narcolapser'  # Replace with your GitHub username

# Calculate the timestamp for 24 hours ago
now = datetime.datetime.utcnow()
time_delta = datetime.timedelta(minutes=15)
since = (now - time_delta).isoformat() + "Z"

# Define the headers for authorization
headers = {
    "Authorization": f"token {GITHUB_API_TOKEN}"
}

# Fetch pull requests reviews from the last 24 hours
def get_reviewed_prs(username, since):
    url = f"{GITHUB_API_URL}/search/issues"
    query = f"reviewed-by:{username} type:pr updated:>={since}"
    params = {"q": query}
    
    response = requests.get(url, headers=headers, params=params)
    response.raise_for_status()  # Raise an error for bad status codes
    data = response.json()

    return data['total_count']

try:
    reviewed_pr_count = get_reviewed_prs(USERNAME, since)
    print(f"You have reviewed {reviewed_pr_count} pull requests in the last {time_delta}.")
    if reviewed_pr_count != 0:
        requests.post(f'https://{HA_AUTHORITY}/api/webhook/dispense-8')
except requests.exceptions.RequestException as e:
    print(f"An error occurred: {e}")

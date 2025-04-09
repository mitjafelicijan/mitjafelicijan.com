"""Fetches my public repositories and downloads tagged versions."""
from datetime import datetime
import sys
import json
import requests

USERNAME = "mitjafelicijan"
CACHE_BUSTER = int(datetime.now().timestamp())
DOUBLE_NL = "\n\n"

headers = {
    "Accept": "application/vnd.github.v3+json"
}


def generate_markdown_file(include_repositories):
    file = open("../content/pages/projects.md", "w")

    file.write("---\n")
    file.write("title: Personal projects\n")
    file.write("date: 2024-10-21T12:00:00+02:00\n")
    file.write("url: projects.html\n")
    file.write("type: page\n")
    file.write("draft: false\n")
    file.write("---")
    file.write(DOUBLE_NL)

    file.write("<div class='project-list'>")
    file.write(DOUBLE_NL)

    for repo in include_repositories:
        file.write(f"- [{repo['name']}](#{repo['name'].lower()}) \n")

    file.write(DOUBLE_NL)
    file.write("</div>")
    file.write(DOUBLE_NL)

    for repo in include_repositories:
        print(f"> {repo['name']}")

        file.write(f"## {repo['name']}\n")
        file.write(f"{repo['description']}\n")

        file.write(DOUBLE_NL)
        file.write("<div class='project-release'>")
        file.write(DOUBLE_NL)
        file.write("|Released|Description|Download|\n")
        file.write("|--------|-----------|--------|\n")

        for release in repo['releases']:
            print(f"   - {release['name']} - {release['created_at']}")
            dt = datetime.strptime(release["created_at"], "%Y-%m-%dT%H:%M:%SZ")
            file.write(f"|{dt.strftime('%Y-%m-%d')}|{release['name']}| [{release['filename']}](/projects/{release['filename']}) |\n")

        file.write(DOUBLE_NL)
        file.write("</div>")
        file.write(DOUBLE_NL)

        file.write("<div class='github-link'>")
        file.write(DOUBLE_NL)
        file.write("![](/assets/general/github.svg)")
        file.write(f"[{USERNAME}/{repo['name']}](https://github.com/{USERNAME}/{repo['name']})")
        file.write(DOUBLE_NL)
        file.write("</div>")
        file.write(DOUBLE_NL)

    file.write(DOUBLE_NL)
    file.write("<style>\n")
    file.write(".project-release table tr td:last-child { text-align: right; }\n")
    file.write(".project-release table tr th:last-child { text-align: right; }\n")
    file.write(".project-list ul { column-count: 3; column-gap: 3em; }\n")
    file.write(".github-link p { display: flex; align-items: center; gap: 0.3em; }\n")
    file.write(".github-link p img { border: 0; padding: 0; height: 15px; }\n")
    file.write("</style>")
    file.write(DOUBLE_NL)

    file.close()



def download_tarball(url, filepath):
    with requests.get(url, stream=True, timeout=30) as response:
        response.raise_for_status()

        with open(filepath, "wb") as file:
            for chunk in response.iter_content(chunk_size=8192):
                file.write(chunk)


def assert_rate_limit(response):
    rate_limit_limit = int(response.headers.get("x-ratelimit-limit"))
    rate_limit_remaining = int(response.headers.get("x-ratelimit-remaining"))
    rate_limit_reset = int(response.headers.get("x-ratelimit-reset"))
    print(f"Rate limit: {rate_limit_remaining}/{rate_limit_limit}")
    print(f"Reset time: {datetime.fromtimestamp(rate_limit_reset)}")

    if rate_limit_remaining == 0:
        sys.exit(1)


def fetch_github_data():
    include_repositories = []
    print(headers)
    response = requests.get(f"https://api.github.com/users/{USERNAME}/repos?ts={CACHE_BUSTER}&per_page=100",
                            headers=headers,
                            timeout=10)

    assert_rate_limit(response)

    if response.status_code == 200:
        repos = response.json()
        for repo in repos:
            # Check if repository has "winc" topic. This means I want to include
            # this repository on this page.
            if "winc" in repo["topics"]:
                include_repositories.append(repo)
    else:
        print(f"Failed to retrieve repositories: {response.status_code}")
        sys.exit(1)

    for repo in include_repositories:
        print(f"Name: {repo['name']}, URL: {repo['html_url']}")

        response = requests.get(f"https://api.github.com/repos/{USERNAME}/{repo['name']}/releases?ts={CACHE_BUSTER}",
                                headers=headers,
                                timeout=10)

        assert_rate_limit(response)

        if response.status_code == 200:
            repo["releases"] = response.json()
            for release in repo["releases"]:
                release["filename"] = f"{repo['name']}-{release['tag_name']}.tar.gz"
                print(f"  > {release['tag_name']}, {release['name']}, {release['filename']}")
                download_tarball(release["tarball_url"], f"../static/projects/{release['filename']}")
        
    return include_repositories


include_repositories = fetch_github_data()

# with open("out.json", "w") as json_file:
#     json.dump(include_repositories, json_file, indent=4)

generate_markdown_file(include_repositories)

# with open("out.json", "r") as fp:
#     include_repositories = json.load(fp)
#     generate_markdown_file(include_repositories)

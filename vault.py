import xml.etree.ElementTree as ET
import requests

url = "https://mitjafelicijan.fra1.digitaloceanspaces.com/"

def truncate_filename(filename, max_length):
    if len(filename) <= max_length:
        return filename
    file_extension = filename.split('.')[-1]
    return f"{filename[:max_length - len(file_extension) - 5]}….{file_extension}"

response = requests.get(url)
if response.status_code == 200:
    xml_data = response.text
    root = ET.fromstring(xml_data)

    # Handle namespace
    ns = {'s3': 'http://s3.amazonaws.com/doc/2006-03-01/'}

    # Create an empty dictionary to hold the tree structure
    tree = {}

    for content in root.findall(".//s3:Contents", ns):
        key = content.find("s3:Key", ns).text
        parts = key.split("/")
        node = tree
        for part in parts:
            if part:
                node = node.setdefault(part, {})

    # Function to convert the tree structure to markdown list
    def tree_to_md(tree, indent=0, path=""):
        md = ""
        for k, v in tree.items():
            if v:  # If the node has children, it's a directory
                md += "  " * indent + f"- {k}\n"
                md += tree_to_md(v, indent + 1, path=f"{path}{k}/")
            else:  # If the node is empty, it's a file
                file_url = f"{url}{path}{k}"
                file_name = truncate_filename(k, 300)
                md += "  " * indent + f"- [{file_name}](<{file_url}>)\n"
        return md

    md = tree_to_md(tree)

    with open("templates/vault.md", "r") as fp:
        content = fp.read()

    new_content = content.replace("{CONTENT}", md)

    with open("content/pages/vault.md", "w") as fp:
        fp.write(new_content)
else:
    print(f"Failed to fetch XML data. Status code: {response.status_code}")

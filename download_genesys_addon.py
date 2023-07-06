import urllib.request
import io
import zipfile
import os
import shutil

def download_git_repo(repo_url, output_dir):
    # Download the ZIP archive of the repository
    zip_url = repo_url + "/archive/master.zip"
    response = urllib.request.urlopen(zip_url)
    zip_data = io.BytesIO(response.read())

    # Extract the ZIP archive to a temporary directory
    temp_dir = "temp"
    with zipfile.ZipFile(zip_data, 'r') as zip_ref:
        zip_ref.extractall(temp_dir)

    # Move the 'event_handlers' folder to the output directory
    extracted_dir = os.path.join(temp_dir, os.listdir(temp_dir)[0])
    event_handlers_dir = os.path.join(extracted_dir, "event_handlers")
    output_path = os.path.join(output_dir, "event_handlers")
    if not os.path.exists(output_dir):
        os.mkdir(output_dir)
    
    if os.path.exists(output_path):
        # delete the existing directory with all its contents
        shutil.rmtree(output_path)

    print("Moving {} to {}".format(event_handlers_dir, output_path))
    # print(os.path.is_dir(event_handlers_dir))
    os.rename(event_handlers_dir, output_path)

    # Clean up the temporary directory
    shutil.rmtree(temp_dir)

# Example usage
repo_url = "https://github.com/Aderemi-Adesada/genesys_kitsu_addon"
output_dir = "genesys_addon"
download_git_repo(repo_url, output_dir)

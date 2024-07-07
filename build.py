import os
import shutil

SHARED_FOLDER_PATH = os.path.abspath("shared")

def replace_shared_folder(module_name: str):
    module_path = os.path.abspath(
        os.path.join(
            "modules",
            module_name,
        )
    )
    module_shared_path = os.path.join(module_path, "shared")

    if os.path.exists(module_shared_path):
        print(f"Updating {module_name}")
        shutil.rmtree(module_shared_path)
    else:
        print(f"Adding shared folder to {module_name}")

    shutil.copytree(src=SHARED_FOLDER_PATH, dst=module_shared_path)

if __name__ == "__main__":
    module_names = os.listdir(os.path.abspath("modules"))
    for module_name in module_names:
        replace_shared_folder(module_name=module_name)
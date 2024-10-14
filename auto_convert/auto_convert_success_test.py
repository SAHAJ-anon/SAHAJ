import os
import subprocess

input_folder = "../contract_store"
output_file_path = "./auto_convert_tests/success_tests"
js_script_path = "./auto-convert-store.js"

total_files = 0
failed_files = 0

for file_name in os.listdir(input_folder):
    input_file_path = os.path.join(input_folder, file_name)
    if os.path.isfile(input_file_path):
        total_files += 1
        try:
            result = subprocess.run(
                ['node', js_script_path, input_file_path, output_file_path],
                check=True,
                stdout=subprocess.PIPE,
                stderr=subprocess.PIPE
            )

        except subprocess.CalledProcessError as e:
            failed_files += 1


    if total_files % 1000 == 0:
        print(f"Total files processed: {total_files}")
        print(f"Total files failed: {failed_files}")
        print(f"Success Rate = {100 - (failed_files / total_files) * 100}%")
    
    if total_files >= 100000:
        break

print(f"Total files processed: {total_files}")
print(f"Total files failed: {failed_files}")
print(f"Success Rate = {100 - (failed_files / total_files) * 100}%")

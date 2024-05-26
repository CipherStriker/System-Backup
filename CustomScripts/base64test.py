from base64 import b64encode,b64decode

#value = 'tomcat:role1'
username = 'tomcat'
password = 'role1'
auth_value = b64encode(f"{username}:{password}".encode('utf-8')).decode('utf-8')

print(auth_value, type(auth_value))

decoded = b64decode(auth_value).decode('utf-8')
print('Decoded value :', decoded)

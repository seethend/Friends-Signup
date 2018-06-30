function openNav() {
    document.getElementById("signupoverlay").style.width = "100%";
    document.getElementById("closeoverlay").style.width = "100%";
    document.documentElement.style.overflow = 'hidden';
}

function closeNav() {
    document.getElementById("signupoverlay").style.width = "0%";
    document.getElementById("closeoverlay").style.width = "0%";
    document.documentElement.style.overflow = 'scroll';
}
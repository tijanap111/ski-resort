<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Registracija - Skijalište</title>
<link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@300;400;600;700&display=swap" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Oswald:wght@700&display=swap" rel="stylesheet">

<style>
    :root {
        --solid-dark-blue: #0b1d33; 
        --akcenat: #7EC8E3;                
        --tekst: #ffffff;
        --polje-dugme: rgba(255, 255, 255, 0.08); 
        --zelena: #76c893;
    }

    body, html {
        margin: 0;
        padding: 0;
        min-height: 100vh;
        width: 100%;
        font-family: 'Montserrat', sans-serif;
        overflow-y: auto; 
    }

    .navbar {
        width: 100%;
        background: rgba(0, 0, 0, 0.6);
        padding: 15px 0;
        display: flex;
        justify-content: center;
        align-items: center;
        position: fixed;
        top: 0;
        left: 0;
        z-index: 1000;
        backdrop-filter: blur(10px);
    }

    .logo-naslov {
        font-family: 'Oswald', sans-serif;
        color: white;
        font-size: 26px;
        font-weight: 700;
        letter-spacing: 6px;
        text-transform: uppercase;
        margin: 0;
        text-shadow: 1px 1px 5px rgba(0,0,0,0.3); 
    }

    .hero-wrapper {
        background-image: linear-gradient(rgba(0, 0, 0, 0.3), rgba(0, 0, 0, 0.3)), 
                          url('${pageContext.request.contextPath}/images/pozadina.jpeg');
        background-size: cover;
        background-position: center center;
        background-attachment: fixed;
        min-height: 100vh;
        width: 100vw;
        display: flex;
        align-items: flex-start;
        justify-content: center;
        padding-top: 140px; 
        padding-bottom: 50px;
        box-sizing: border-box;
    }

    .main-container {
        background-color: var(--solid-dark-blue); 
        border: 1px solid rgba(255, 255, 255, 0.1);
        border-radius: 24px;
        padding: 45px;
        width: 90%;
        max-width: 450px;
        box-shadow: 0 40px 80px rgba(0,0,0,0.8);
        color: white;
        text-align: center;
       transform: translateY(0) !important; 
        position: relative;
        z-index: 1;
    }

    h2 {
        font-size: 24px;
        font-weight: 700;
        color: var(--akcenat);
        text-transform: uppercase;
        letter-spacing: 2px;
        margin-top: 0;
    }

    .subtitle {
        font-size: 11px;
        opacity: 0.6;
        font-weight: 300;
        margin-bottom: 30px;
        text-transform: uppercase;
    }

    .input-group {
        text-align: left;
        margin-bottom: 20px;
    }

    .input-group label {
        font-size: 10px;
        font-weight: 700;
        color: var(--akcenat);
        text-transform: uppercase;
        letter-spacing: 1px;
        display: block;
        margin-bottom: 8px;
    }

    .input-group input {
        width: 100%;
        background: var(--polje-dugme);
        border: 1px solid rgba(255, 255, 255, 0.1);
        padding: 12px 15px;
        border-radius: 8px;
        color: white;
        font-family: 'Montserrat', sans-serif;
        box-sizing: border-box;
        transition: 0.3s;
    }

    .input-group input:focus {
        outline: none;
        border-color: var(--akcenat);
        background: rgba(255, 255, 255, 0.15);
    }

    .btn-register {
        background: var(--akcenat);
        color: var(--solid-dark-blue);
        border: none;
        padding: 15px;
        width: 100%;
        border-radius: 12px;
        font-weight: 700;
        font-size: 13px;
        text-transform: uppercase;
        letter-spacing: 1px;
        cursor: pointer;
        transition: all 0.3s ease;
        margin-top: 10px;
    }

    .btn-register:hover {
        transform: translateY(-3px);
        box-shadow: 0 10px 20px rgba(126, 200, 227, 0.3);
        filter: brightness(1.1);
    }

    .success-msg {
        background: rgba(118, 200, 147, 0.15);
        color: var(--zelena);
        padding: 12px;
        border-radius: 10px;
        font-size: 12px;
        margin-bottom: 20px;
        border: 1px solid var(--zelena);
    }

    .footer-link {
        margin-top: 25px;
        display: block;
        font-size: 11px;
        color: rgba(255, 255, 255, 0.5);
        text-decoration: none;
        letter-spacing: 0.5px;
    }

    .footer-link b {
        color: var(--akcenat);
    }

    .footer-link:hover b {
        text-decoration: underline;
    }
</style>
</head>
<body>

<div class="navbar">
    <h1 class="logo-naslov">~ SKIJALIŠTE ~</h1>
</div>

<div class="hero-wrapper">
    <div class="main-container">
        <h2>Novi nalog</h2>
        <p class="subtitle">Postani deo planinske priče</p>

        <c:if test="${param.success}">
            <div class="success-msg">
                ✓ USPEŠNA REGISTRACIJA! MOŽETE SE PRIJAVITI.
            </div>
        </c:if>

        <form action="register" method="post">
            <div class="input-group">
                <label>Ime</label>
                <input type="text" name="ime" placeholder="UNESITE IME" required>
            </div>
            
            <div class="input-group">
                <label>Prezime</label>
                <input type="text" name="prezime" placeholder="UNESITE PREZIME" required>
            </div>

            <div class="input-group">
                <label>Email adresa</label>
                <input type="email" name="email" placeholder="PRIMER@GMAIL.COM" required>
            </div>

            <div class="input-group">
                <label>Lozinka</label>
                <input type="password" name="lozinka" placeholder="MINIMUM 6 KARAKTERA" required>
            </div>

            <button type="submit" class="btn-register">KREIRAJ NALOG</button>
        </form>

        <a href="${pageContext.request.contextPath}/nalog/getLogin" class="footer-link">
            VEĆ IMATE NALOG? <b>PRIJAVITE SE</b>
        </a>
    </div>
</div>

</body>
</html>
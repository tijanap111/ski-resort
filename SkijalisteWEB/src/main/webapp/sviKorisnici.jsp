<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Pronađi skijaše - Skijalište</title>
<link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@300;400;600;700&display=swap" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Oswald:wght@700&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

<style>
    :root {
        --solid-dark-blue: #0b1d33; 
        --akcenat: #7EC8E3;                
        --tekst: #ffffff;
        --polje-dugme: rgba(255, 255, 255, 0.08); 
        --zelena: #76c893;
        --crvena: #e74c3c;
    }

    body, html {
        margin: 0;
        padding: 0;
        min-height: 100vh;
        width: 100%;
        font-family: 'Montserrat', sans-serif;
        overflow-x: hidden;
    }

    .navbar {
        width: 100%;
        background: rgba(0, 0, 0, 0.5);
        padding: 12px 0;
        display: flex;
        justify-content: center;
        align-items: center;
        position: fixed;
        top: 0;
        left: 0;
        z-index: 1000;
        backdrop-filter: blur(8px);
    }

    .logo-naslov {
        font-family: 'Oswald', sans-serif;
        color: white;
        font-size: 26px;
        font-weight: 700;
        letter-spacing: 6px;
        text-transform: uppercase;
        margin: 0;
        text-shadow: 2px 2px 8px rgba(0,0,0,0.5); 
    }

    .hero-wrapper {
        background: linear-gradient(rgba(0, 0, 0, 0.4), rgba(0, 0, 0, 0.4)), 
                    url('${pageContext.request.contextPath}/images/pozadina.jpeg');
        background-size: cover;
        background-position: center center;
        background-attachment: fixed;
        min-height: 100vh;
        width: 100vw;
        display: flex;
        align-items: flex-start;
        justify-content: center;
        padding-top: 130px; 
        padding-bottom: 100px;
        box-sizing: border-box;
    }

    .main-container {
        background-color: var(--solid-dark-blue); 
        border: 1px solid rgba(255, 255, 255, 0.1);
        border-radius: 20px;
        padding: 40px;
        width: 90%;
        max-width: 750px;
        box-shadow: 0 30px 60px rgba(0,0,0,0.6);
        color: white;
        backdrop-filter: blur(5px);
    }

    .header-section {
        margin-bottom: 30px;
        border-bottom: 1px solid rgba(255,255,255,0.1);
        padding-bottom: 15px;
        text-align: center;
    }

    .header-section h2 {
        font-family: 'Oswald', sans-serif;
        font-size: 24px;
        letter-spacing: 2px;
        color: var(--akcenat);
        margin: 0;
        text-transform: uppercase;
    }

    .alert-success {
        background: rgba(118, 200, 147, 0.2);
        color: var(--zelena);
        padding: 15px;
        border-radius: 12px;
        margin-bottom: 25px;
        border: 1px solid var(--zelena);
        font-size: 13px;
        font-weight: 600;
        text-align: center;
    }

    .user-card {
        background: var(--polje-dugme);
        border: 1px solid rgba(255, 255, 255, 0.05);
        padding: 20px;
        border-radius: 15px;
        margin-bottom: 12px;
        display: flex;
        justify-content: space-between;
        align-items: center;
        transition: 0.3s ease;
    }

    .user-card:hover {
        background: rgba(255, 255, 255, 0.12);
        transform: scale(1.01);
    }

    .user-info strong {
        font-size: 16px;
        display: block;
        color: var(--tekst);
    }

    .user-info span {
        font-size: 12px;
        color: var(--akcenat);
        opacity: 0.8;
    }

    .btn-add {
        background: var(--akcenat);
        color: var(--solid-dark-blue);
        padding: 10px 18px;
        text-decoration: none;
        border-radius: 8px;
        font-size: 11px;
        font-weight: 800;
        text-transform: uppercase;
        letter-spacing: 1px;
        transition: all 0.3s ease;
    }

    .btn-add:hover {
        transform: translateY(-2px);
        box-shadow: 0 5px 15px rgba(126, 200, 227, 0.4);
    }

    .btn-fixed-bottom {
        position: fixed;
        bottom: 30px;
        z-index: 2000;
        background: var(--solid-dark-blue);
        color: white;
        padding: 12px 25px;
        border-radius: 50px;
        text-decoration: none;
        font-weight: 700;
        font-size: 11px;
        text-transform: uppercase;
        letter-spacing: 1px;
        box-shadow: 0 10px 20px rgba(0,0,0,0.4);
        transition: 0.3s;
        border: 1px solid rgba(255, 255, 255, 0.1);
    }

    .left-fixed {
        left: 30px;
    }

    .right-fixed {
        right: 30px;
    }

    .btn-fixed-bottom:hover {
        transform: scale(1.1);
        background: var(--akcenat);
        color: var(--solid-dark-blue);
    }

    .logout-fixed:hover {
        background: var(--crvena) !important;
        color: white !important;
    }

</style>
</head>
<body>

<div class="navbar">
    <h1 class="logo-naslov">~ SKIJALIŠTE ~</h1>
</div>

<div class="hero-wrapper">
    <div class="main-container">
        <div class="header-section">
            <h2>PRONAĐI SKIJAŠE</h2>
        </div>

        <c:if test="${param.sent}">
            <div class="alert-success">
                <i class="fa-solid fa-circle-check"></i> Zahtev za prijateljstvo je uspešno poslat!
            </div>
        </c:if>

        <c:forEach var="k" items="${sviKorisnici}">
            <c:if test="${k.korisnikId != ulogovaniKorisnik.korisnikId}">
                <div class="user-card">
                    <div class="user-info">
                        <strong>${k.ime} ${k.prezime}</strong>
                        <span>${k.email}</span>
                    </div>
                    <a href="${pageContext.request.contextPath}/nalog/posaljiZahtev?idP=${k.korisnikId}" class="btn-add">
                        <i class="fa-solid fa-user-plus"></i> DODAJ PRIJATELJA
                    </a>
                </div>
            </c:if>
        </c:forEach>
    </div>
</div>

<c:choose>
    <c:when test="${ulogovaniKorisnik.uloga == 'ADMIN'}">
        <a href="${pageContext.request.contextPath}/nalog/admin" class="btn-fixed-bottom left-fixed">
           ← NAZAD NA DASHBOARD
        </a>
    </c:when>
    <c:otherwise>
        <a href="${pageContext.request.contextPath}/nalog/korisnikProfil" class="btn-fixed-bottom left-fixed">
           ← NAZAD NA PROFIL
        </a>
    </c:otherwise>
</c:choose>

<a href="${pageContext.request.contextPath}/nalog/logout" class="btn-fixed-bottom right-fixed logout-fixed">
   ODJAVI SE
</a>

</body>
</html>
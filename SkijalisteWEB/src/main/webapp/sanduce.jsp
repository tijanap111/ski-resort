<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Poruke - Skijalište</title>
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
        max-width: 950px;
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

    table {
        width: 100%;
        border-collapse: separate;
        border-spacing: 0 10px;
        margin-top: 10px;
    }

    th {
        font-family: 'Oswald', sans-serif;
        color: var(--akcenat);
        text-transform: uppercase;
        letter-spacing: 1px;
        font-size: 14px;
        padding: 10px 15px;
        text-align: left;
        border-bottom: 1px solid rgba(255,255,255,0.1);
    }

    td {
        background: var(--polje-dugme);
        padding: 15px;
        font-size: 13px;
        color: white;
        border: none;
    }

    td:first-child { border-radius: 12px 0 0 12px; }
    td:last-child { border-radius: 0 12px 12px 0; border-right: none; }

    tr:hover td {
        background: rgba(255,255,255,0.12);
        color: var(--akcenat);
    }

    .vreme-tekst {
        font-size: 11px;
        opacity: 0.6;
        font-weight: 300;
    }

    .prazno-msg {
        text-align: center;
        padding: 50px;
        opacity: 0.5;
        font-weight: 300;
        font-style: italic;
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

    .left-fixed { left: 30px; }
    .right-fixed { right: 30px; }

    .btn-fixed-bottom:hover {
        transform: scale(1.1);
        background: var(--akcenat);
        color: var(--solid-dark-blue);
    }

    .logout-fixed:hover { background: var(--crvena) !important; color: white !important; }

</style>
</head>
<body>

<div class="navbar">
    <h1 class="logo-naslov">~ SKIJALIŠTE ~</h1>
</div>

<div class="hero-wrapper">
    <div class="main-container">
        <div class="header-section">
            <h2>PRIMLJENE PORUKE</h2>
        </div>

        <c:choose>
            <c:when test="${not empty listaPoruka}">
                <table>
                    <thead>
                        <tr>
                            <th style="width: 25%;">Pošiljalac</th>
                            <th style="width: 50%;">Sadržaj</th>
                            <th style="width: 25%;">Datum i vreme</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${listaPoruka}" var="p">
                            <tr>
                                <td><i class="fa-solid fa-user-tag" style="color: var(--akcenat); margin-right: 8px;"></i> <strong>${p.posiljalac.ime} ${p.posiljalac.prezime}</strong></td>
                                <td>${p.sadrzaj}</td>
                                <td class="vreme-tekst">
                                    <i class="fa-regular fa-clock"></i> 
                                    <fmt:formatDate value="${p.datumSlanja}" pattern="dd.MM.yyyy. HH:mm"/>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </c:when>
            <c:otherwise>
                <div class="prazno-msg">
                    <i class="fa-solid fa-envelope-open" style="font-size: 30px; display: block; margin-bottom: 15px;"></i>
                    Vaše sanduče je trenutno prazno.
                </div>
            </c:otherwise>
        </c:choose>
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
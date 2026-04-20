<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Prijatelji - Skijalište</title>
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
        max-width: 800px;
        box-shadow: 0 30px 60px rgba(0,0,0,0.6);
        color: white;
        backdrop-filter: blur(5px);
    }

    .header-section {
        margin-bottom: 35px;
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

    .sekcija-naslov {
        font-size: 12px;
        text-transform: uppercase;
        letter-spacing: 2px;
        color: var(--akcenat);
        margin: 25px 0 15px 0;
        font-weight: 700;
        display: block;
    }

    .friend-item {
        background: var(--polje-dugme);
        border: 1px solid rgba(255, 255, 255, 0.05);
        padding: 15px 20px;
        border-radius: 15px;
        margin-bottom: 12px;
        display: flex;
        justify-content: space-between;
        align-items: center;
        transition: 0.3s ease;
    }

    .friend-item:hover {
        background: rgba(255, 255, 255, 0.12);
        transform: scale(1.01);
    }

    .friend-name {
        font-weight: 600;
        font-size: 15px;
    }

    .actions {
        display: flex;
        gap: 10px;
    }

    .btn {
        padding: 8px 15px;
        text-decoration: none;
        border-radius: 8px;
        font-size: 11px;
        font-weight: 700;
        text-transform: uppercase;
        letter-spacing: 1px;
        transition: 0.3s;
        border: none;
        cursor: pointer;
    }

    .btn-prihvati { background: var(--zelena); color: var(--solid-dark-blue); }
    .btn-odbij { background: var(--crvena); color: white; }
    
    .btn:hover { transform: translateY(-2px); filter: brightness(1.1); }

    .msg-input {
        background: rgba(255, 255, 255, 0.1);
        border: 1px solid rgba(255, 255, 255, 0.2);
        padding: 8px 12px;
        border-radius: 8px;
        color: white;
        font-size: 12px;
        width: 200px;
        outline: none;
        transition: 0.3s;
    }

    .msg-input:focus {
        border-color: var(--akcenat);
        background: rgba(255, 255, 255, 0.15);
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
            <h2>Prijateljstva i Zahtevi</h2>
        </div>

        <span class="sekcija-naslov">Zahtevi na čekanju</span>
        <c:choose>
            <c:when test="${not empty zahtevi}">
                <c:forEach items="${zahtevi}" var="z">
                    <div class="friend-item">
                        <span class="friend-name">${z.posiljalac.ime} ${z.posiljalac.prezime}</span>
                        <div class="actions">
                            <a href="${pageContext.request.contextPath}/prijateljstvo/prihvati?idP=${z.prijateljstvoId}" class="btn btn-prihvati">PRIHVATI</a>
                            <a href="${pageContext.request.contextPath}/prijateljstvo/odbij?idP=${z.prijateljstvoId}" class="btn btn-odbij">ODBIJ</a>
                        </div>
                    </div>
                </c:forEach>
            </c:when>
            <c:otherwise>
                <p style="color: rgba(255,255,255,0.4); font-size: 13px; font-style: italic; margin-left: 5px;">Nema novih zahteva.</p>
            </c:otherwise>
        </c:choose>

        <span class="sekcija-naslov" style="margin-top: 40px;">Moji Prijatelji</span>
        <c:choose>
            <c:when test="${not empty prijatelji}">
                <c:forEach items="${prijatelji}" var="p">
                    <div class="friend-item">
                        <span class="friend-name">
                            <c:choose>
                                <c:when test="${p.posiljalac.korisnikId == ulogovaniKorisnik.korisnikId}">
                                    ${p.primalac.ime} ${p.primalac.prezime}
                                    <c:set var="targetId" value="${p.primalac.korisnikId}" />
                                </c:when>
                                <c:otherwise>
                                    ${p.posiljalac.ime} ${p.posiljalac.prezime}
                                    <c:set var="targetId" value="${p.posiljalac.korisnikId}" />
                                </c:otherwise>
                            </c:choose>
                        </span>
                        
                        <form action="${pageContext.request.contextPath}/poruke/posaljiPoruku" method="post" style="display: flex; gap: 8px;">
                            <input type="hidden" name="idPrimaoca" value="${targetId}">
                            <input type="text" name="tekst" class="msg-input" placeholder="Pošalji brzu poruku..." required>
                            <button type="submit" class="btn btn-prihvati" style="background: var(--akcenat); padding: 8px 12px;">
                                <i class="fa-solid fa-paper-plane"></i>
                            </button>
                        </form>
                    </div>
                </c:forEach>
            </c:when>
            <c:otherwise>
                <p style="color: rgba(255,255,255,0.4); font-size: 13px; font-style: italic; margin-left: 5px;">Vaša lista prijatelja je prazna.</p>
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
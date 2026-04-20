<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Detalji staze: ${izabranaStaza.naziv}</title>
<link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@300;400;600;700&display=swap" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Oswald:wght@700&display=swap" rel="stylesheet">

<style>
    :root {
        --solid-dark-blue: #0b1d33; 
        --akcenat: #7EC8E3;                
        --tekst: #ffffff;
        --polje-dugme: rgba(255, 255, 255, 0.08); 
        --zelena: #2ecc71;
        --crvena: #e74c3c;
    }

    body, html {
        margin: 0;
        padding: 0;
        height: 100vh;
        width: 100%;
        font-family: 'Montserrat', sans-serif;
        overflow: hidden; 
    }

    .hero-wrapper {
        background-image: url('${pageContext.request.contextPath}/images/pozadina.jpeg');
        background-size: cover;
        background-position: center center;
        background-repeat: no-repeat;
        height: 100vh;
        width: 100vw;
        display: flex;
        align-items: center; 
        justify-content: center;
        position: relative;
        padding-top: 40px; 
        box-sizing: border-box;
    }

    .navbar {
        width: 100%;
        background: rgba(0, 0, 0, 0.4);
        padding: 12px 0;
        display: flex;
        justify-content: center;
        align-items: center;
        position: fixed;
        top: 0;
        left: 0;
        z-index: 1000;
    }

    .logo-naslov {
        font-family: 'Oswald', sans-serif;
        color: white;
        font-size: 26px;
        font-weight: 700;
        letter-spacing: 6px;
        text-transform: uppercase;
        margin: 0;
    }

    .main-container {
        background-color: var(--solid-dark-blue); 
        border: 1px solid rgba(255, 255, 255, 0.1);
        border-radius: 20px;
        padding: 30px;
        width: 80%;
        max-width: 900px;
        display: grid;
        grid-template-columns: 0.8fr 1.2fr;
        gap: 25px;
        box-shadow: 0 30px 60px rgba(0,0,0,0.6);
        color: white;
        z-index: 2;
        transform: translateY(-20px); 
    }

    .image-section img {
        width: 100%;
        height: 350px; 
        border-radius: 12px;
        border: 2px solid var(--akcenat);
        object-fit: cover;
    }

    .no-image {
        background: var(--polje-dugme);
        height: 350px;
        display: flex;
        align-items: center;
        justify-content: center;
        border-radius: 12px;
        border: 2px dashed rgba(255,255,255,0.2);
    }

    h2 {
        font-family: 'Oswald', sans-serif;
        font-size: 28px;
        margin: 0 0 15px 0;
        color: var(--akcenat);
        text-transform: uppercase;
    }

    .info-row {
        display: flex;
        justify-content: space-between;
        padding: 10px 0;
        border-bottom: 1px solid var(--polje-dugme);
    }

    .info-label {
        font-size: 11px;
        font-weight: 700;
        text-transform: uppercase;
        color: rgba(255,255,255,0.5);
    }

    .admin-box {
        margin-top: 20px;
        padding: 15px;
        background: rgba(255, 255, 255, 0.05);
        border-radius: 12px;
        border: 1px solid rgba(126, 200, 227, 0.3);
    }

    .admin-btn {
        width: 100%;
        padding: 10px;
        border: none;
        border-radius: 8px;
        color: white;
        font-weight: 700;
        font-family: 'Montserrat', sans-serif;
        cursor: pointer;
        text-transform: uppercase;
        transition: 0.3s;
    }

    .btn-close-staza { background: linear-gradient(45deg, #e74c3c, #c0392b); }
    .btn-open-staza { background: linear-gradient(45deg, #2ecc71, #27ae60); }
    .admin-btn:hover { opacity: 0.9; transform: scale(1.02); }

    .status-text {
        font-weight: 800;
        letter-spacing: 1px;
    }

    .btn-fixed {
        position: fixed;
        bottom: 30px;
        z-index: 2000;
        padding: 12px 25px;
        border-radius: 50px;
        text-decoration: none;
        font-weight: 700;
        font-size: 11px;
        text-transform: uppercase;
        color: white;
        border: 1px solid var(--akcenat);
        background: var(--solid-dark-blue);
    }
    .btn-back-fixed { left: 30px; }
    .btn-logout-fixed { right: 30px; }
</style>
</head>
<body>

<div class="navbar">
    <h1 class="logo-naslov">~ SKIJALIŠTE ~</h1>
</div>

<div class="hero-wrapper">
    <div class="main-container">
        <div class="image-section">
            <c:choose>
                <c:when test="${not empty izabranaStaza.slika}">
                    <img src="${pageContext.request.contextPath}/images/staze/${izabranaStaza.slika}" alt="Slika staze">
                </c:when>
                <c:otherwise>
                    <div class="no-image">Nema dostupne slike</div>
                </c:otherwise>
            </c:choose>
        </div>

        <div class="info-section">
            <h2>${izabranaStaza.naziv}</h2>
            
            <div class="info-row">
                <span class="info-label">Trenutni status:</span>
                <span class="status-text" style="color: ${izabranaStaza.status == 'OTVORENA' ? 'var(--zelena)' : 'var(--crvena)'}">
                    ${izabranaStaza.status}
                </span>
            </div>

            <c:if test="${ulogovaniKorisnik.uloga == 'ADMIN'}">
                <div class="admin-box">
                    <p style="font-size: 10px; color: var(--akcenat); margin-bottom: 10px; font-weight: bold;">(ADMIN)</p>
                    <form action="${pageContext.request.contextPath}/staze/promeniStatus" method="post">
                        <input type="hidden" name="stazaId" value="${izabranaStaza.stazaId}"> 
                        
                        <c:choose>
                            <c:when test="${izabranaStaza.status == 'OTVORENA'}">
                                <button type="submit" class="admin-btn btn-close-staza">Zatvori stazu</button>
                            </c:when>
                            <c:otherwise>
                                <button type="submit" class="admin-btn btn-open-staza">Otvori stazu</button>
                            </c:otherwise>
                        </c:choose>
                    </form>
                </div>
            </c:if>

            <div style="margin-top: 20px;">
                <div class="info-row">
                    <span class="info-label">Težina:</span>
                    <span class="info-value">${izabranaStaza.tezina}</span>
                </div>
                <div class="info-row">
                    <span class="info-label">Kategorija:</span>
                    <span class="info-value">${izabranaStaza.kategorijaStaze.naziv}</span>
                </div>
                <div class="info-row">
                    <span class="info-label">Dužina:</span>
                    <span class="info-value">${izabranaStaza.duzina} m</span>
                </div>
                <div class="info-row">
                    <span class="info-label">Vrh:</span>
                    <span class="info-value">${izabranaStaza.nadmorskaVisinaVrh} m</span>
                </div>
                <div class="info-row">
                    <span class="info-label">Dno:</span>
                    <span class="info-value">${izabranaStaza.nadmorskaVisinaDno} m</span>
                </div>
            </div>
        </div>
    </div>
</div>

<a href="${pageContext.request.contextPath}/staze/sveStaze" class="btn-fixed btn-back-fixed">← NAZAD NA LISTU</a>
<a href="${pageContext.request.contextPath}/nalog/logout" class="btn-fixed btn-logout-fixed">ODJAVI SE</a>

</body>
</html>
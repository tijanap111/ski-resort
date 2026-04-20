<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Skijalište - Upravljanje Stazama</title>
<link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@300;400;600;700&display=swap" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Oswald:wght@700&display=swap" rel="stylesheet">

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
        padding: 35px;
        width: 90%;
        max-width: 1000px;
        box-shadow: 0 30px 60px rgba(0,0,0,0.6);
        color: white;
        z-index: 2;
        
        margin-top: 30px;
        max-height: 75vh;
        overflow-y: auto;
        transform: translateY(-20px);
    }

    h2 {
        font-family: 'Oswald', sans-serif;
        text-transform: uppercase;
        letter-spacing: 2px;
        color: var(--akcenat);
        margin-top: 0;
        border-bottom: 2px solid var(--polje-dugme);
        padding-bottom: 10px;
        font-size: 22px;
    }

    .filter-section {
        background: var(--polje-dugme);
        padding: 15px;
        border-radius: 12px;
        margin-bottom: 20px;
    }

    select {
        background: var(--solid-dark-blue);
        color: white;
        border: 1px solid var(--akcenat);
        padding: 6px 12px;
        border-radius: 6px;
        font-family: 'Montserrat', sans-serif;
    }

    table {
        width: 100%;
        border-collapse: collapse;
    }

    th {
        text-align: left;
        color: var(--akcenat);
        text-transform: uppercase;
        font-size: 11px;
        letter-spacing: 1px;
        padding: 15px 10px;
        border-bottom: 2px solid var(--polje-dugme);
    }

    td {
        padding: 12px 10px;
        border-bottom: 1px solid var(--polje-dugme);
        font-size: 13px;
    }

    .btn-mini {
        background: var(--akcenat);
        color: var(--solid-dark-blue);
        border: none;
        padding: 5px 12px;
        border-radius: 4px;
        cursor: pointer;
        text-decoration: none;
        font-weight: 700;
        font-size: 10px;
        text-transform: uppercase;
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
        letter-spacing: 1px;
        box-shadow: 0 10px 20px rgba(0,0,0,0.4);
        transition: 0.3s;
        display: flex;
        align-items: center;
        gap: 8px;
    }

    .btn-fixed:hover {
        transform: scale(1.05);
    }

    .btn-back-fixed {
        left: 30px;
        background: var(--solid-dark-blue);
        border: 1px solid var(--akcenat);
        color: white;
    }

    .btn-back-fixed:hover {
        background: var(--akcenat);
        color: var(--solid-dark-blue);
    }

    .btn-logout-fixed {
        right: 30px;
        background: var(--solid-dark-blue);
        color: white;
    }

    .btn-logout-fixed:hover {
        background: #c0392b;
    }

    .main-container::-webkit-scrollbar { width: 6px; }
    .main-container::-webkit-scrollbar-thumb { background: var(--polje-dugme); border-radius: 10px; }
</style>
</head>
<body>

<div class="navbar">
    <h1 class="logo-naslov">~ SKIJALIŠTE ~</h1>
</div>

<div class="hero-wrapper">
    <div class="main-container">
        <div class="filter-section">
            <form action="${pageContext.request.contextPath}/staze/pretraga" method="get" style="display: flex; align-items: center; gap: 15px;">
                <label style="font-size: 10px; font-weight: 700; text-transform: uppercase;">Kategorija:</label>
                <select name="idKat">
                    <option value="0">Sve kategorije</option>
                    <c:forEach var="k" items="${kategorije}">
                        <option value="${k.kategorijaId}">${k.naziv}</option>
                    </c:forEach>
                </select>
                <button type="submit" class="btn-mini">FILTRIRAJ</button>
            </form>
        </div>

        <table>
            <thead>
                <tr>
                    <th>Naziv staze</th>
                    <th>Dužina</th>
                    <th>Kategorija</th>
                    <th>Akcije</th>
                </tr>
            </thead>
            <tbody>
			    <c:forEach var="s" items="${staze}">
			        <tr>
			            <td style="font-weight: 600;">${s.naziv}</td>
			            <td style="opacity: 0.7;">${s.duzina}m</td>
			            <td><span style="color: var(--akcenat);">${s.kategorijaStaze.naziv}</span></td>
			            <td>
			                <a href="${pageContext.request.contextPath}/staze/detalji?ids=${s.stazaId}" class="btn-mini">DETALJI</a>
			                
			                <c:if test="${not empty ulogovaniKorisnik && ulogovaniKorisnik.uloga != 'ADMIN'}">
			                    <a href="${pageContext.request.contextPath}/staze/dodajUOmiljene?ids=${s.stazaId}" 
			                       title="Dodaj u omiljene" 
			                       style="text-decoration: none; margin-left: 10px;">⭐</a>
			                </c:if>
			            </td>
			        </tr>
			    </c:forEach>
			</tbody>
        </table>
    </div>
</div>

<c:choose>
    <c:when test="${not empty ulogovaniKorisnik && ulogovaniKorisnik.uloga == 'ADMIN'}">
        <a href="${pageContext.request.contextPath}/nalog/admin" class="btn-fixed btn-back-fixed">← KONTROLNA TABLA</a>
    </c:when>

    <c:when test="${not empty ulogovaniKorisnik}">
        <a href="${pageContext.request.contextPath}/nalog/korisnikProfil" class="btn-fixed btn-back-fixed">← MOJ PROFIL</a>
    </c:when>

    <c:otherwise>
        <a href="${pageContext.request.contextPath}/" class="btn-fixed btn-back-fixed">← POČETNA STRANA</a>
    </c:otherwise>
</c:choose>

<c:choose>
    <c:when test="${not empty ulogovaniKorisnik}">
        <a href="${pageContext.request.contextPath}/nalog/logout" class="btn-fixed btn-logout-fixed">
            ODJAVI SE
        </a>
    </c:when>
    <c:otherwise>
        <a href="${pageContext.request.contextPath}/nalog/login" class="btn-fixed btn-logout-fixed" style="background: var(--akcenat); color: var(--solid-dark-blue);">
            PRIJAVI SE
        </a>
    </c:otherwise>
</c:choose>

</body>
</html>
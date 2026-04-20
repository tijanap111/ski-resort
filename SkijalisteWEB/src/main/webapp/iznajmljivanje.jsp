<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Iznajmljivanje - Skijalište</title>
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
        padding-top: 140px; 
        padding-bottom: 100px;
        box-sizing: border-box;
    }

    .main-container {
        background-color: var(--solid-dark-blue); 
        border: 1px solid rgba(255, 255, 255, 0.1);
        border-radius: 20px;
        padding: 40px;
        width: 90%;
        max-width: 500px;
        box-shadow: 0 30px 60px rgba(0,0,0,0.6);
        color: white;
        backdrop-filter: blur(5px);
        text-align: center;
    }

    h2 {
        font-family: 'Oswald', sans-serif;
        font-size: 24px;
        letter-spacing: 2px;
        color: var(--akcenat);
        margin: 0 0 5px 0;
        text-transform: uppercase;
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

    select, input {
        width: 100%;
        background: var(--polje-dugme);
        border: 1px solid rgba(255, 255, 255, 0.1);
        padding: 12px 15px;
        border-radius: 10px;
        color: white;
        font-family: 'Montserrat', sans-serif;
        box-sizing: border-box;
        transition: 0.3s ease;
        outline: none;
    }

    select option { background: var(--solid-dark-blue); color: white; }

    select:focus, input:focus {
        border-color: var(--akcenat);
        background: rgba(255, 255, 255, 0.15);
    }

    .btn-submit {
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
        transition: all 0.3s;
        margin-top: 10px;
    }

    .btn-submit:hover {
        transform: translateY(-3px);
        box-shadow: 0 10px 20px rgba(126, 200, 227, 0.3);
    }

    .poruka-uspeh {
        background: rgba(118, 200, 147, 0.15);
        color: var(--zelena);
        padding: 12px;
        border-radius: 10px;
        font-size: 11px;
        margin-bottom: 20px;
        border: 1px solid var(--zelena);
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
        <h2><i class="fa-solid fa-ski-boot"></i> IZNAJMLJIVANJE</h2>
        <p class="subtitle">Opremite se za savršen spust</p>

        <c:if test="${not empty poruka}">
            <div class="poruka-uspeh">
                <i class="fa-solid fa-circle-check"></i> ${poruka}
            </div>
        </c:if>

        <form action="${pageContext.request.contextPath}/iznajmljivanje/iznajmi" method="post">
            <div class="input-group">
                <label>Izaberite opremu:</label>
                <select name="idOpreme">
                    <c:forEach items="${svaOprema}" var="o">
                        <option value="${o.opremaId}">${o.naziv} - ${o.cenaPoSatu} RSD/h</option>
                    </c:forEach>
                </select>
            </div>
            <div class="input-group">
                <label>Broj sati:</label>
                <input type="number" name="sati" min="1" max="24" value="1">
            </div>
            <button type="submit" class="btn-submit">POTVRDI IZNAJMLJIVANJE</button>
        </form>
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
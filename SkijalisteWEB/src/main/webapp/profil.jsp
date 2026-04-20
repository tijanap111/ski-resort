<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>

<html>

<head>

<meta charset="UTF-8">

<title>Moj profil - Skijalište</title>

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


text-shadow: 1px 1px 5px rgba(0,0,0,0.3);

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




.main-container {

background-color: var(--solid-dark-blue);

border: 1px solid rgba(255, 255, 255, 0.1);

border-radius: 20px;

padding: 40px;

width: 85%;

max-width: 950px;

display: grid;

grid-template-columns: 280px 1fr;

gap: 30px;

box-shadow: 0 30px 60px rgba(0,0,0,0.6);

color: white;

z-index: 2;




transform: translateY(-30px);

}



.profile-sidebar {

text-align: center;

border-right: 1px solid rgba(255,255,255,0.1);

padding-right: 25px;

}



.profile-sidebar img {

width: 150px;

height: 150px;

border-radius: 50%;

border: 3px solid var(--akcenat);

object-fit: cover;

margin-bottom: 15px;

}



.dashboard-grid {

display: grid;

grid-template-columns: repeat(3, 1fr);

gap: 12px;

}



.dash-item {

background: var(--polje-dugme);

border: 1px solid rgba(255, 255, 255, 0.05);

padding: 15px;

border-radius: 12px;

color: white;

text-decoration: none;

text-align: center;

font-weight: 600;

font-size: 11px;

transition: all 0.3s ease;

display: flex;

flex-direction: column;

align-items: center;

justify-content: center;

height: 85px;

}



.dash-item:hover {

background: var(--akcenat);

color: var(--solid-dark-blue);

transform: translateY(-5px);

}



.ime-tekst {

margin: 0;

font-size: 24px;

font-weight: 700;

color: var(--akcenat);

}



.prezime-tekst {

margin: 0 0 10px 0;

font-size: 24px;

font-weight: 300;

text-transform: uppercase;

letter-spacing: 1px;

}



.section-title {

font-size: 12px;

text-transform: uppercase;

letter-spacing: 2px;

color: var(--akcenat);

margin-bottom: 20px;

display: block;

font-weight: 700;

}




.logout-fixed {

position: fixed;

bottom: 30px;

right: 30px;

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

}



.logout-fixed:hover {

transform: scale(1.1);

background: #c0392b;

}

</style>

</head>

<body>



<div class="navbar">

<h1 class="logo-naslov">~ SKIJALIŠTE ~</h1>

</div>



<div class="hero-wrapper">

<div class="main-container">

<div class="profile-sidebar">

<c:choose>

<c:when test="${not empty ulogovaniKorisnik.slika}">

<img src="${pageContext.request.contextPath}/images/users/${ulogovaniKorisnik.slika}" alt="Profil"/>

</c:when>

<c:otherwise>

<img src="${pageContext.request.contextPath}/images/default-user.png" alt="Default"/>

</c:otherwise>

</c:choose>



<h3 class="ime-tekst">${ulogovaniKorisnik.ime}</h3>

<h3 class="prezime-tekst">${ulogovaniKorisnik.prezime}</h3>

<p style="font-size: 11px; opacity: 0.5; font-weight: 300;">${ulogovaniKorisnik.email}</p>

</div>



<div class="profile-main">

<div class="dashboard-grid">

<a href="${pageContext.request.contextPath}/staze/sveStaze" class="dash-item">POGLEDAJ SVE STAZE</a>

<a href="${pageContext.request.contextPath}/nalog/omiljeneStaze" class="dash-item">OMILJENE STAZE</a>

<a href="${pageContext.request.contextPath}/prijateljstvo/prijatelji" class="dash-item">PRIJATELJI</a>

<a href="${pageContext.request.contextPath}/nalog/sviKorisnici" class="dash-item">PRONAĐI PRIJATELJE</a>

<a href="${pageContext.request.contextPath}/poruke/sanduce" class="dash-item">PORUKE</a>

<a href="${pageContext.request.contextPath}/iznajmljivanje/getForma" class="dash-item">IZNAJMI OPREMU</a>

</div>

</div>

</div>

</div>

</div>



<a href="${pageContext.request.contextPath}/nalog/logout" class="logout-fixed">

ODJAVI SE

</a>



</body>

</html>
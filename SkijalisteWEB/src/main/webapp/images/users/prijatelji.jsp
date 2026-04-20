<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<title>Prijatelji</title>
</head>
<body>

<h2>Moji prijatelji</h2>

<c:forEach var="p" items="${prijatelji}">
    <c:choose>
        <c:when test="${p.posiljalac.korisnikId == korisnik.korisnikId}">
            <p>${p.primalac.ime} ${p.primalac.prezime}
                <a href="${pageContext.request.contextPath}/poruke/${p.primalac.korisnikId}">Pošalji poruku</a>
            </p>
        </c:when>
        <c:otherwise>
            <p>${p.posiljalac.ime} ${p.posiljalac.prezime}
                <a href="${pageContext.request.contextPath}/poruke/${p.posiljalac.korisnikId}">Pošalji poruku</a>
            </p>
        </c:otherwise>
    </c:choose>
</c:forEach>

<h2>Zahtevi za prijateljstvo</h2>

<c:if test="${empty zahtevi}">
    <p>Nema novih zahteva.</p>
</c:if>

<c:forEach var="z" items="${zahtevi}">
    <p>${z.posiljalac.ime} ${z.posiljalac.prezime}
        <a href="${pageContext.request.contextPath}/prijateljstvo/prihvati/${z.prijateljstvoId}">Prihvati</a>
        <a href="${pageContext.request.contextPath}/prijateljstvo/odbij/${z.prijateljstvoId}">Odbij</a>
    </p>
</c:forEach>

<br>
<a href="${pageContext.request.contextPath}/profilController/profil">Nazad na profil</a>

</body>
</html>
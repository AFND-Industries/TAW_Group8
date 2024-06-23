<%--
  Created by IntelliJ IDEA.
  User: Eulogio Quemada
  Date: 23/06/2024
  Time: 16:51
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="modal fade" id="recover-modal" data-keyboard="false" data-backdrop="static">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h1 class="modal-title fs-5" id="recover-modal-label">Recuperar rutina</h1>
            </div>
            <div class="modal-body" id="recover-modal-body">
                Hemos detectado que estabas editando o creando una rutina. ¿Deseas recuperar la rutina?
            </div>
            <div class="modal-footer">
                <form action="/entrenador/rutinas/recuperar" method="post">
                    <input type="submit" class="btn btn-success" value="Recuperar"/>
                </form>
                <form action="/entrenador/rutinas/descartar" method="post">
                    <input type="submit" class="btn btn-danger" value="Descartar"/>
                </form>
            </div>
        </div>
    </div>
</div>
<%--
  Created by IntelliJ IDEA.
  User: Eulogio Quemada
  Date: 23/06/2024
  Time: 13:32
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="modal fade" id="volver-modal">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h1 class="modal-title fs-5" id="volver-modal-label">Volver</h1>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body" id="volver-modal-body">
                ¿Estás seguro de que quieres volver?
                Perderás toda la información añadida o editada hasta ahora.
            </div>
            <div class="modal-footer">
                <button id="volver-modal-button" type="button" class="btn btn-danger">Volver</button>
                <button type="button" class="btn btn-primary" data-bs-dismiss="modal">Cancelar</button>
            </div>
        </div>
    </div>
</div>
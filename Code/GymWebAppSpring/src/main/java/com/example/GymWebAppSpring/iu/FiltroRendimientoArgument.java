package com.example.GymWebAppSpring.iu;

public class FiltroRendimientoArgument {
    private Integer sesionEntrenamientoId;
    private String nombre;
    private Integer objetivosMode;
    private String obejetivosNum;
    private Integer objetivosSuperadosMode;
    private String objetivosSuperadosNum;
    private Integer tipoEjercicio;

    public FiltroRendimientoArgument() {
        this.sesionEntrenamientoId = -1;
        this.obejetivosNum = "";
        this.nombre = "";
        this.objetivosMode = -1;
        this.objetivosSuperadosNum = "";
        this.objetivosSuperadosMode = -1;
        this.tipoEjercicio = -1;
    }

    public Integer getSesionEntrenamientoId() {
        return sesionEntrenamientoId;
    }

    public void setSesionEntrenamientoId(Integer sesionEntrenamientoId) {
        this.sesionEntrenamientoId = sesionEntrenamientoId;
    }

    public Integer getObjetivosSuperadosMode() {
        return objetivosSuperadosMode;
    }

    public void setObjetivosSuperadosMode(Integer objetivosSuperadosMode) {
        this.objetivosSuperadosMode = objetivosSuperadosMode;
    }

    public String getObjetivosSuperadosNum() {
        return objetivosSuperadosNum;
    }

    public void setObjetivosSuperadosNum(String objetivosSuperadosNum) {
        this.objetivosSuperadosNum = objetivosSuperadosNum;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public Integer getObjetivosMode() {
        return objetivosMode;
    }

    public void setObjetivosMode(Integer objetivosMode) {
        this.objetivosMode = objetivosMode;
    }

    public String getObejetivosNum() {
        return obejetivosNum;
    }

    public void setObejetivosNum(String obejetivosNum) {
        this.obejetivosNum = obejetivosNum;
    }

    public Integer getTipoEjercicio() {
        return tipoEjercicio;
    }

    public void setTipoEjercicio(Integer tipoEjercicio) {
        this.tipoEjercicio = tipoEjercicio;
    }

    public Integer getIntegerObjetivosNum() {
        return this.obejetivosNum.isEmpty() ? -1 : Integer.parseInt(obejetivosNum);
    }

    public Integer getIntegerObjetivosSuperadosNum() {
        return this.objetivosSuperadosNum.isEmpty() ? -1 : Integer.parseInt(objetivosSuperadosNum);
    }

    public boolean estaVacio() {
        return this.obejetivosNum.isEmpty() && this.objetivosMode == -1 && this.objetivosSuperadosNum.isEmpty() && this.objetivosSuperadosMode == -1 && this.tipoEjercicio == -1 && this.nombre.isEmpty();
    }
}

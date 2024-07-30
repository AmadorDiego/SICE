package mx.edu.utez.sice.model;

public class Calificacion {
    private int id_calificacion;
    private int calificacion;
    private int id_usuario;
    private int id_aplicacion;

    public Calificacion(int id_calificacion, int calificacion, int id_usuario, int id_aplicacion) {
        this.id_calificacion = id_calificacion;
        this.calificacion = calificacion;
        this.id_usuario = id_usuario;
        this.id_aplicacion = id_aplicacion;
    }

    public int getId_calificacion() {
        return id_calificacion;
    }

    public void setId_calificacion(int id_calificacion) {
        this.id_calificacion = id_calificacion;
    }

    public int getCalificacion() {
        return calificacion;
    }

    public void setCalificacion(int calificacion) {
        this.calificacion = calificacion;
    }

    public int getId_usuario() {
        return id_usuario;
    }

    public void setId_usuario(int id_usuario) {
        this.id_usuario = id_usuario;
    }

    public int getId_aplicacion() {
        return id_aplicacion;
    }

    public void setId_aplicacion(int id_aplicacion) {
        this.id_aplicacion = id_aplicacion;
    }
}

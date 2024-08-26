package mx.edu.utez.sice.model;

public class RespuestaAbierta {
    private int id_pregunta;
    private int id_aplicacion;
    private String respuesta;
    private boolean correcta;

    public RespuestaAbierta() {

    }

    public RespuestaAbierta(int id_pregunta, int id_aplicacion, String respuesta, boolean correcta) {
        this.id_pregunta = id_pregunta;
        this.id_aplicacion = id_aplicacion;
        this.respuesta = respuesta;
        this.correcta = correcta;
    }

    public int getId_pregunta() {
        return id_pregunta;
    }

    public void setId_pregunta(int id_pregunta) {
        this.id_pregunta = id_pregunta;
    }

    public int getId_aplicacion() {
        return id_aplicacion;
    }

    public void setId_aplicacion(int id_aplicacion) {
        this.id_aplicacion = id_aplicacion;
    }

    public String getRespuesta() {
        return respuesta;
    }

    public void setRespuesta(String respuesta) {
        this.respuesta = respuesta;
    }

    public boolean isCorrecta() {
        return correcta;
    }

    public void setCorrecta(boolean correcta) {
        this.correcta = correcta;
    }
}

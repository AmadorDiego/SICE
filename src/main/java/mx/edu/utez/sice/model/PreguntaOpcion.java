package mx.edu.utez.sice.model;

public class PreguntaOpcion {
    private int id_pregunta;
    private int id_opcion;
    private int correcta;


    public PreguntaOpcion() {
    }

    public PreguntaOpcion(int id_pregunta, int id_opcion, int correcta) {
        this.id_pregunta = id_pregunta;
        this.id_opcion = id_opcion;
        this.correcta = correcta;
    }

    public int getId_pregunta() {
        return id_pregunta;
    }

    public void setId_pregunta(int id_pregunta) {
        this.id_pregunta = id_pregunta;
    }

    public int getId_opcion() {
        return id_opcion;
    }

    public void setId_opcion(int id_opcion) {
        this.id_opcion = id_opcion;
    }

    public int getCorrecta() {
        return correcta;
    }

    public void setCorrecta(int correcta) {
        this.correcta = correcta;
    }
/*
    //Agregue este metodo de SET OPCION CUANDO MODIFIQUE crearExamenServlet
    public void setOpcion(Opcion opcion) {
        this.id_opcion = id_opcion;
    }

    public PreguntaOpcion getOpcion() {
        return this;
    }*/
}

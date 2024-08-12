package mx.edu.utez.sice.model;

import java.util.ArrayList;

public class Pregunta {
        private int id_pregunta;
        private String pregunta;
        private int id_tipo_pregunta;
        //Agregue un arrayList
        private ArrayList<Integer> opciones;

    public Pregunta() {
    }

    public Pregunta(int id_pregunta, String pregunta, int id_tipo_pregunta, ArrayList<Integer> opciones) {
            this.id_pregunta = id_pregunta;
            this.pregunta = pregunta;
            this.id_tipo_pregunta = id_tipo_pregunta;
            //Agregue un arrayList
            this.opciones = new ArrayList<>();
        }
    
        public int getId_pregunta() {
            return id_pregunta;
        }
    
        public void setId_pregunta(int id_pregunta) {
            this.id_pregunta = id_pregunta;
        }
    
        public String getPregunta() {
            return pregunta;
        }
    
        public void setPregunta(String pregunta) {
            this.pregunta = pregunta;
        }
    
        public int getId_tipo_pregunta() {
            return id_tipo_pregunta;
        }
    
        public void setId_tipo_pregunta(int id_tipo_pregunta) {
            this.id_tipo_pregunta = id_tipo_pregunta;
        }

    public ArrayList<Integer> getOpciones() {
        return opciones;
    }

    public void setOpciones(ArrayList<Integer> opciones) {
        this.opciones = opciones;
    }
}

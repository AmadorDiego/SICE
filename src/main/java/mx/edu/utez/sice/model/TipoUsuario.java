package mx.edu.utez.sice.model;

public class TipoUsuario {
    private int id_tipo_usuario;
    private String tipo_usuario;

    public TipoUsuario() {
    }

    public TipoUsuario(int id_tipo_usuario, String tipo_usuario) {
        this.id_tipo_usuario = id_tipo_usuario;
        this.tipo_usuario = tipo_usuario;
    }

    public int getId_tipo_usuario() {
        return id_tipo_usuario;
    }

    public void setId_tipo_usuario(int id_tipo_usuario) {
        this.id_tipo_usuario = id_tipo_usuario;
    }

    public String getTipo_usuario() {
        return tipo_usuario;
    }

    public void setTipo_usuario(String tipo_usuario) {
        this.tipo_usuario = tipo_usuario;
    }
}

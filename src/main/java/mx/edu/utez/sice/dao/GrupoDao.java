package mx.edu.utez.sice.dao;

import mx.edu.utez.sice.model.Grupo;
import mx.edu.utez.sice.model.Usuario;
import mx.edu.utez.sice.utils.DatabaseConnectionManager;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
//se agrego Dao grupo
public class GrupoDao {

    public ArrayList<Grupo> getAll() {
        ArrayList<Grupo> lista = new ArrayList<>();
        try (Connection con = DatabaseConnectionManager.getConnection()) {
            String query = "SELECT * FROM grupo";
            PreparedStatement ps = con.prepareStatement(query);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Grupo g = new Grupo();
                g.setId_grupo(rs.getInt("id_grupo"));
                g.setGrupo(rs.getString("grupo").charAt(0));
                g.setGrado(rs.getInt("grado"));
                g.setId_periodo(rs.getInt("periodo_id_periodo"));
                lista.add(g);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return lista;
    }
}


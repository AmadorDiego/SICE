package mx.edu.utez.sice.dao;

import mx.edu.utez.sice.model.Grupo;
import mx.edu.utez.sice.model.Periodo;
import mx.edu.utez.sice.utils.DatabaseConnectionManager;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class PeriodoDao {

    public ArrayList<Periodo> getAll() {
        ArrayList<Periodo> lista = new ArrayList<>();
        try (Connection con = DatabaseConnectionManager.getConnection()) {
            String query = "SELECT * FROM periodo";
            PreparedStatement ps = con.prepareStatement(query);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Periodo periodo = new Periodo();
                periodo.setId_periodo(rs.getInt("id_periodo"));
                periodo.setDescripcion(rs.getString("descripcion"));
                periodo.setFecha_inicio(rs.getString("fecha_inicio"));
                periodo.setFecha_final(rs.getString("fecha_final"));
                lista.add(periodo);
            }
            rs.close();
            ps.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return lista;
    }
}

using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using Capstone.Models;

namespace Capstone.DAO {
    public class ImagesSqlDao : IImagesDao {
        private readonly string _connectionString;

        public ImagesSqlDao(string dbConnectionString) {
            _connectionString = dbConnectionString;
        }

        public IList<Images> GetAllImagesByUnitId(int unitId) {
            IList<Images> imgList = new List<Images>();

            try {
                using (SqlConnection conn = new SqlConnection(_connectionString)) {
                    conn.Open();
                    var sql = 
                        "SELECT image_url " +
                        "FROM unit_images " +
                        "WHERE unit_id = @unitId;";
                    SqlCommand cmd = new SqlCommand(sql, conn);
                    cmd.Parameters.AddWithValue("@unitId", unitId);
                    SqlDataReader reader = cmd.ExecuteReader();

                    while (reader.Read()) {
                        imgList.Add(GetAllImagesByUnitIdFromReader(reader));
                    }
                }
            } catch (Exception) {
                throw;
            }
            return imgList;
        }

        private Images GetAllImagesByUnitIdFromReader(SqlDataReader reader) {
            Images images = new Images() {
                imageUrl = Convert.ToString(reader["image_url"])
            };
            return images;
        }
    }
}

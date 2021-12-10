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

        public IList<Images> GetAllImages() {
            IList<Images> imgList = new List<Images>();

            try {
                using (SqlConnection conn = new SqlConnection(_connectionString)) {
                    conn.Open();
                    var sql = 
                        "SELECT image_id, image_url, description, unit_id " +
                        "FROM images";
                    SqlCommand cmd = new SqlCommand(sql, conn);
                    SqlDataReader reader = cmd.ExecuteReader();

                    while (reader.Read()) {
                        imgList.Add(GetAllImagesFromReader(reader));
                    }
                }
            } catch (Exception) {
                throw;
            }
            return imgList;
        }

        private Images GetAllImagesFromReader(SqlDataReader reader) {
            Images images = new Images() {
                imageId = Convert.ToInt32(reader["image_id"]),
                imageUrl = Convert.ToString(reader["image_url"]),
                description = Convert.ToString(reader["description"]),
                unitId = Convert.ToInt32(reader["unit_id"])
            };
            return images;
        }
    }
}

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

        public IList<Images> GetAllUnitImagesByPropertyId(int propertyId) {
            IList<Images> imgList = new List<Images>();

            try {
                using (SqlConnection conn = new SqlConnection(_connectionString)) {
                    conn.Open();
                    var sql =
                        "SELECT ui.image_id, ui.image_url, ui.image_caption " +
                        "FROM unit_images ui " +
                        "INNER JOIN units u ON u.unit_id = ui.unit_id " +
                        "WHERE u.property_id = @propertyId AND u.is_rented = 0;";
                    SqlCommand cmd = new SqlCommand(sql, conn);
                    cmd.Parameters.AddWithValue("@propertyId", propertyId);
                    SqlDataReader reader = cmd.ExecuteReader();

                    while (reader.Read()) {
                        imgList.Add(GetAllUnitImagesByPropertyIdFromReader(reader));
                    }
                }
            } catch (Exception) {
                throw;
            }
            return imgList;
        }

        private Images GetAllUnitImagesByPropertyIdFromReader(SqlDataReader reader) {
            Images images = new Images() {
                imageId = Convert.ToInt32(reader["image_id"]),
                imageUrl = Convert.ToString(reader["image_url"]),
                imageCaption = Convert.ToString(reader["image_caption"])
            };
            return images;
        }
    }
}

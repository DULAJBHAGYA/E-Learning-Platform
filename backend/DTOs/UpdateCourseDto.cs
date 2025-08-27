using System.ComponentModel.DataAnnotations;

namespace ELearningAPI.DTOs
{
    public class UpdateCourseDto
    {
        [StringLength(200)]
        public string? Title { get; set; }

        public string? Description { get; set; }

        public string? Thumbnail { get; set; }

        [Range(0, double.MaxValue)]
        public decimal? Price { get; set; }

        public string? Category { get; set; }

        public string? Level { get; set; }

        [Range(1, int.MaxValue)]
        public int? Duration { get; set; }
    }
}

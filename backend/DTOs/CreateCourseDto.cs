using System.ComponentModel.DataAnnotations;

namespace ELearningAPI.DTOs
{
    public class CreateCourseDto
    {
        [Required]
        [StringLength(200)]
        public string Title { get; set; } = string.Empty;

        [Required]
        public string Description { get; set; } = string.Empty;

        public string? Thumbnail { get; set; }

        [Required]
        [Range(0, double.MaxValue)]
        public decimal Price { get; set; }

        [Required]
        public string Category { get; set; } = string.Empty;

        [Required]
        public string Level { get; set; } = "Beginner";

        [Required]
        [Range(1, int.MaxValue)]
        public int Duration { get; set; }
    }
}

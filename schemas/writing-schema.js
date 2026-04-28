const { z } = require("zod");

const bandScore = z.number().min(0).max(9).multipleOf(0.5);

const writingSchema = z.object({
  type: z.literal("writing"),
  date: z.string().regex(/^\d{4}-\d{2}-\d{2}$/),
  task: z.enum(["task1", "task2"]),
  question_type: z.enum([
    "opinion",
    "discussion",
    "advantages-disadvantages",
    "problem-solution",
    "two-part",
    "bar-chart",
    "line-chart",
    "pie-chart",
    "table",
    "map",
    "process",
  ]),
  word_count: z.number().int().min(0),
  scores: z.object({
    tr: bandScore,
    cc: bandScore,
    lr: bandScore,
    gra: bandScore,
    overall: bandScore,
  }),
  target: bandScore,
  errors: z.array(
    z.object({
      category: z.enum(["tr", "cc", "lr", "gra"]),
      description: z.string(),
    })
  ),
  improvements: z.array(z.string()),
});

module.exports = { writingSchema };

import {UnitEnrollment} from "../modules/unitEnrollment.js";

export const enrollStudentInUnit = async (req, res) => {
  try {
    const { studentID, unitOfferingID } = req.body;

    const [enrollment, created] = await UnitEnrollment.findOrCreate({
      where: { studentID, unitOfferingID },
      defaults: {}
    });

    res.status(created ? 201 : 200).json({
      message: created ? "Student enrolled successfully" : "Already enrolled",
      enrollment
    });
  } catch (err) {
    console.error("Error enrolling student:", err);
    res.status(500).json({ error: "Failed to enroll student" });
  }
};
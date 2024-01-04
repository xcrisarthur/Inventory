<template>
  <div>
    <h1>Employee List</h1>

    <!-- Display message if no employee is selected -->
    <div v-if="!selectedEmployee">
      <p>No employee selected. Please select an employee to generate the CV.</p>
    </div>

    <!-- Button to select an employee for generating CV -->
    <div class="mb-3">
      <label for="employeeSelect">Select Employee:</label>
      <select id="employeeSelect" v-model="selectedEmployee" @change="selectEmployee">
        <option value="">Select an employee</option>
        <option v-for="employee in employeeData" :key="employee.nomor_induk" :value="employee">
          {{ employee.nama }}
        </option>
      </select>
    </div>

    <!-- Employee CV Section -->
    <div ref="employeeCvSection" v-if="selectedEmployee">
      <h2>{{ selectedEmployee.nama }}'s CV</h2>
      <p>Nomor Induk: {{ selectedEmployee.nomor_induk }}</p>

      <!-- Display Skills based on Employee Nomor Induk -->
      <h3>Skills</h3>
      <ul>
        <li v-for="skill in getSkillsByEmployee(selectedEmployee.nomor_induk)" :key="skill.id_skill">{{ skill.nama }} - Level: {{ skill.level }} - Notes: {{ skill.notes }}</li>
      </ul>

      <!-- Display Portfolios based on Employee Nomor Induk -->
      <h3>Portfolios</h3>
      <ul>
        <li v-for="portfolio in getPortfoliosByEmployee(selectedEmployee.nomor_induk)" :key="portfolio.id_portfolio">{{ portfolio.nama }} - {{ portfolio.tanggal }} - Role: {{ portfolio.role }} - Technology: {{ portfolio.technology }}</li>
      </ul>

      <div class="d-flex flex-row mb-3">
        <div class="p-2 me-5">
          <button type="button" class="btn btn-primary" @click="createCV" :disabled="!selectedEmployee">Create CV</button>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import axios from 'axios';
import jsPDF from 'jspdf';

export default {
  data() {
    return {
      loading: true,
      error: null,
      employeeData: [],
      skillData: [],
      portfolioData: [],
      EmployeeskillData: [],
      EmployeeportfolioData: [],
      selectedEmployee: null,
    };
  },
  async mounted() {
    try {
      // Fetching data for employees
      const employeesResponse = await axios.get('http://localhost:8080/api/employees');
      console.log('Employee Data:', employeesResponse.data.employees);
      this.employeeData = employeesResponse.data.employees;

      // Fetching data for skills
      const skillsResponse = await axios.get('http://localhost:8080/api/skills');
      console.log('Skill Data:', skillsResponse.data.skills);
      this.skillData = skillsResponse.data.skills;

      // Fetching data for portfolios
      const portfoliosResponse = await axios.get('http://localhost:8080/api/portfolio');
      console.log('Portfolio Data:', portfoliosResponse.data.portfolios);
      this.portfolioData = portfoliosResponse.data.portfolios;

      // Fetching data for employee skills
      const employeeSkillsResponse = await axios.get('http://localhost:8080/api/employeeSkills');
      console.log('Employee Skill Data:', employeeSkillsResponse.data.skillEmployees);
      this.EmployeeskillData = employeeSkillsResponse.data.skillEmployees;

      // Fetching data for employee portfolios
      const employeePortfoliosResponse = await axios.get('http://localhost:8080/api/employeePortfolio');
      console.log('Employee Portfolio Data:', employeePortfoliosResponse.data.portfolioEmployees);
      this.EmployeeportfolioData = employeePortfoliosResponse.data.portfolioEmployees;
    } catch (error) {
      console.error('Error fetching data:', error);
      this.error = 'Failed to fetch data';
    } finally {
      this.loading = false;
    }
  },
  methods: {
    // ...

    getSkillsByEmployee(nomorInduk) {
      const employeeSkills = this.EmployeeskillData.filter((skill) => skill.nomor_induk === nomorInduk);

      return employeeSkills.map((skill) => {
        const skillInfo = skill.Skill;
        return {
          id_skill: skillInfo.id_skill,
          nama: skillInfo.nama,
          level: skillInfo.level,
          notes: skillInfo.notes,
        };
      });
    },

    getPortfoliosByEmployee(nomorInduk) {
      const employeePortfolios = this.EmployeeportfolioData.filter((portfolio) => portfolio.nomor_induk === nomorInduk);

      return employeePortfolios.map((portfolio) => {
        const portfolioInfo = portfolio.Portfolio;
        return {
          id_portfolio: portfolioInfo.id_portfolio,
          nama: portfolioInfo.nama,
          tanggal: portfolioInfo.tanggal,
          role: portfolioInfo.role,
          technology: portfolioInfo.technology,
        };
      });
    },
    createCV() {
      // Create a new jsPDF instance
      const pdf = new jsPDF({ unit: 'mm', format: 'a4', orientation: 'portrait' });

      // Set options
      const options = {
        margin: 10,
      };

      // Add header
      pdf.setFontSize(16);
      pdf.text(`CV - ${this.selectedEmployee.nama}`, options.margin, options.margin);

      // Add employee details
      pdf.setFontSize(12);
      pdf.text(`Nomor Induk: ${this.selectedEmployee.nomor_induk}`, options.margin, options.margin + 10);

      // Add Skills
      pdf.setFontSize(14);
      pdf.text('Skills', options.margin, options.margin + 20);
      pdf.setFontSize(12);
      const skills = this.getSkillsByEmployee(this.selectedEmployee.nomor_induk);
      skills.forEach((skill, index) => {
        pdf.text(`${index + 1}. ${skill.nama} - Level: ${skill.level} - Notes: ${skill.notes}`, options.margin + 10, options.margin + 30 + index * 10);
      });

      // Add Portfolios
      pdf.setFontSize(14);
      pdf.text('Portfolios', options.margin, options.margin + 40 + skills.length * 10);
      pdf.setFontSize(12);
      const portfolios = this.getPortfoliosByEmployee(this.selectedEmployee.nomor_induk);
      portfolios.forEach((portfolio, index) => {
        pdf.text(`${index + 1}. ${portfolio.nama} - ${portfolio.tanggal} - Role: ${portfolio.role} - Technology: ${portfolio.technology}`, options.margin + 10, options.margin + 50 + skills.length * 10 + index * 10);
      });

      // Save the PDF with the specified filename
      pdf.save('employee_cv.pdf');
    },
  },
};
</script>

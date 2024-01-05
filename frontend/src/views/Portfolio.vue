<template>
  <div>
    <h1>Employee List</h1>

    <!-- Display message if no employee is selected -->
    <div v-if="!selectedEmployee">
      <p>No employee selected. Please select an employee to generate the CV.</p>
    </div>

    <!-- Button to select an employee for generating CV -->
    <div class="mb-3 d-flex">
      <h3 for="employeeSelect">Select Employee : </h3>
      <select id="employeeSelect" v-model="selectedEmployee" @change="selectEmployee" class="form-select w-25 mx-3">
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
      // console.log('Employee Data:', employeesResponse.data.employees);
      this.employeeData = employeesResponse.data.employees;

      // Fetching data for skills
      const skillsResponse = await axios.get('http://localhost:8080/api/skills');
      // console.log('Skill Data:', skillsResponse.data.skills);
      this.skillData = skillsResponse.data.skills;

      // Fetching data for portfolios
      const portfoliosResponse = await axios.get('http://localhost:8080/api/portfolio');
      // console.log('Portfolio Data:', portfoliosResponse.data.portfolios);
      this.portfolioData = portfoliosResponse.data.portfolios;

      // Fetching data for employee skills
      const employeeSkillsResponse = await axios.get('http://localhost:8080/api/employeeSkills');
      // console.log('Employee Skill Data:', employeeSkillsResponse.data.skillEmployees);
      this.EmployeeskillData = employeeSkillsResponse.data.skillEmployees;

      // Fetching data for employee portfolios
      const employeePortfoliosResponse = await axios.get('http://localhost:8080/api/employeePortfolio');
      // console.log('Employee Portfolio Data:', employeePortfoliosResponse.data.portfolioEmployees);
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

      // Add title
      pdf.setFontSize(18);
      pdf.text('Curriculum Vitae', pdf.internal.pageSize.getWidth() / 2, options.margin, { align: 'center' });

      // Add image from CDN
      const imgData = this.selectedEmployee.gambar; // Assuming selectedEmployee.gambar is a valid CDN link
      pdf.addImage(imgData, 'JPEG', pdf.internal.pageSize.getWidth() / 2 - 20, options.margin + 10, 40, 40);

      // Add name
      pdf.setFontSize(16);
      pdf.text(this.selectedEmployee.nama, pdf.internal.pageSize.getWidth() / 2, options.margin + 60, { align: 'center' });

      // Add employee details in a table
      pdf.autoTable({
        head: [['Field', 'Value']],
        body: [
          ['Nama', this.selectedEmployee.nama],
          ['Gender', this.selectedEmployee.gender],
          ['Email', this.selectedEmployee.email],
          ['Telepon', this.selectedEmployee.telepon],
          ['Jabatan', this.selectedEmployee.jabatan],
          ['Divisi', this.selectedEmployee.divisi],
          ['Alamat', this.selectedEmployee.alamat],
        ],
        startY: options.margin + 80,
        margin: { top: options.margin + 80 },
      });

      // Add Skills in a table
      const skills = this.getSkillsByEmployee(this.selectedEmployee.nomor_induk);
      const skillHeaders = ['No.', 'Skill', 'Level', 'Notes'];
      const skillData = skills.map((skill, index) => [index + 1, skill.nama, skill.level, skill.notes]);

      pdf.autoTable({
        head: [skillHeaders],
        body: skillData,
        startY: pdf.autoTable.previous.finalY + 10,
        margin: { top: pdf.autoTable.previous.finalY + 10 },
      });

      // Add Portfolios in a table
      const portfolios = this.getPortfoliosByEmployee(this.selectedEmployee.nomor_induk);
      const portfolioHeaders = ['No.', 'Portfolio', 'Date', 'Role', 'Technology'];
      const portfolioData = portfolios.map((portfolio, index) => [index + 1, portfolio.nama, portfolio.tanggal, portfolio.role, portfolio.technology]);

      pdf.autoTable({
        head: [portfolioHeaders],
        body: portfolioData,
        startY: pdf.autoTable.previous.finalY + 10,
        margin: { top: pdf.autoTable.previous.finalY + 10 },
      });

      // Save the PDF with the specified filename
      pdf.save('employee_cv.pdf');
    },
  },
};
</script>

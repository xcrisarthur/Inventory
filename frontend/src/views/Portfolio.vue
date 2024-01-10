<template>
  <div>
    <h1>Employee List</h1>

    <!-- Display message if no employee is selected -->
    <div v-if="!selectedEmployee">
      <p>No employee selected. Please select an employee to generate the CV.</p>
    </div>

    <!-- Button to select an employee for generating CV -->
    <div class="mb-3 d-flex">
      <h3 for="employeeSelect">Select Employee :</h3>
      <select id="employeeSelect" v-model="selectedEmployee" @change="selectEmployee" class="form-select w-25 mx-3">
        <option value="">Select an employee</option>
        <option v-for="employee in employeeData" :key="employee.nomor_induk" :value="employee">
          {{ employee.nama }}
        </option>
      </select>
    </div>

    <!-- Employee CV Section -->
    <div ref="employeeCvSection" v-if="selectedEmployee">
      <div class="container">
        <div class="row">
          <div class="col-6 text-center">
            <h2>{{ selectedEmployee.nama }}'s CV</h2>
            <p>Nomor Induk: {{ selectedEmployee.nomor_induk }}</p>
            <img :src="selectedEmployee.gambar" style="width: 100%; height: auto; max-width: 300px; max-height: 300px"
              alt="" />
          </div>
          <div class="col-6">
            <h3>Skills</h3>
            <ul>
              <li v-for="skill in getSkillsByEmployee(selectedEmployee.nomor_induk)" :key="skill.id_skill">{{ skill.nama
              }} - Level: {{ skill.level }} - Notes: {{ skill.notes }}</li>
            </ul>
            <h3>Portfolios</h3>
            <ul>
              <li v-for="portfolio in getPortfoliosByEmployee(selectedEmployee.nomor_induk)"
                :key="portfolio.id_portfolio">{{ portfolio.nama }} - {{ portfolio.tanggal }} - Role: {{ portfolio.role }}
                - Technology: {{ portfolio.technology }}</li>
            </ul>
          </div>
          <div class="col-12 text-center">
            <button type="button" class="btn btn-primary me-auto" @click="createCV" :disabled="!selectedEmployee">Create
              CV</button>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import axios from 'axios';
import jsPDF from 'jspdf';
import headerImg from '@/assets/img/header.png';
import footerImg from '@/assets/img/footer.png';
import JakartaSansTTF from '@/assets/fonts/jakarta.ttf';

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
      pdf.addFileToVFS('jakarta.ttf', JakartaSansTTF);
      pdf.addFont('jakarta.ttf', 'JakartaSans', 'normal');

      // Set options
      const options = {
        margin: 10,
        fontSize: 12,
        headerTextColor: '#000000', // White text for headers
        headerColor: '#b5b5b5', // Header background color for grid theme
      };

      // Set Header with Image using autoTable
      pdf.autoTable({
        margin: { top: 0 },
        beforePageContent: function () {
          pdf.addImage(headerImg, 'PNG', 0, 0, 210, 27.5);
        },
      });

      // Set Footer with Image using autoTable
      pdf.autoTable({
        margin: { bottom: 0 },
        afterPageContent: function () {
          pdf.addImage(footerImg, 'PNG', 0, pdf.internal.pageSize.height - 35, 210, 35);
        },
      });

      // Add title with margin
      const titleMargin = 30; // Adjust this value as needed
      pdf.setFontSize(28);
      pdf.text('Curriculum Vitae', pdf.internal.pageSize.getWidth() / 2, options.margin + titleMargin, { align: 'center', startY: options.margin + titleMargin });

      // Add image to the left
      const imgData = this.selectedEmployee.gambar; // Assuming selectedEmployee.gambar is a valid CDN link
      pdf.addImage(imgData, 'JPEG', options.margin, options.margin + 50, 40, 40);

      // Add employee details to the right
      pdf.autoTable({
        theme: 'grid', // Set theme to 'grid'
        headStyles: { textColor: options.headerTextColor, fontSize: options.fontSize },
        bodyStyles: { textColor: '#000000', fontSize: options.fontSize },
        body: [
          ['Nama', this.selectedEmployee.nama],
          ['Gender', this.selectedEmployee.gender],
          ['Alamat', this.selectedEmployee.alamat],
          ['Email', this.selectedEmployee.email],
          ['Telepon', this.selectedEmployee.telepon],
          ['Jabatan', this.selectedEmployee.jabatan],
          ['Divisi', this.selectedEmployee.divisi],
        ],
        startY: options.margin + 40,
        margin: { top: options.margin + 10, left: 60 },
        tableLineColor: [0, 0, 0],
        tableLineWidth: 0.2,
        styles: { cellWidth: 'wrap', cellPadding: 2, border: '1', halign: 'left' },
      });

      // Add Keahlian (Skills) section
      pdf.setFontSize(20);
      pdf.text('Keahlian', pdf.internal.pageSize.getWidth() / 2, pdf.autoTable.previous.finalY + 15, { align: 'center' });

      // Add Skills in a table
      const skills = this.getSkillsByEmployee(this.selectedEmployee.nomor_induk);
      const skillHeaders = ['No.', 'Skill', 'Level', 'Notes'];
      const skillData = skills.map((skill, index) => [index + 1, skill.nama, skill.level, skill.notes]);

      pdf.autoTable({
        theme: 'grid', // Set theme to 'grid'
        headStyles: { fillColor: options.headerColor, textColor: options.headerTextColor, fontSize: options.fontSize },
        bodyStyles: { textColor: '#000000', fontSize: options.fontSize },
        head: [skillHeaders],
        body: skillData,
        startY: pdf.autoTable.previous.finalY + 20,
        margin: { top: pdf.autoTable.previous.finalY + 20 },
        tableLineColor: [0, 0, 0],
        tableLineWidth: 0.2,
        styles: { cellWidth: 'wrap', cellPadding: 2, border: '1', halign: 'left' },
      });

      // Add Portfolio section
      pdf.setFontSize(20);
      pdf.text('Portfolio', pdf.internal.pageSize.getWidth() / 2, pdf.autoTable.previous.finalY + 15, { align: 'center' });

      // Add Portfolios in a table
      const portfolios = this.getPortfoliosByEmployee(this.selectedEmployee.nomor_induk);
      const portfolioHeaders = ['No.', 'Portfolio', 'Date', 'Role', 'Technology'];
      const portfolioData = portfolios.map((portfolio, index) => [index + 1, portfolio.nama, portfolio.tanggal, portfolio.role, portfolio.technology]);

      pdf.autoTable({
        theme: 'grid', // Set theme to 'grid'
        headStyles: { fillColor: options.headerColor, textColor: options.headerTextColor, fontSize: options.fontSize },
        bodyStyles: { textColor: '#000000', fontSize: options.fontSize },
        head: [portfolioHeaders],
        body: portfolioData,
        startY: pdf.autoTable.previous.finalY + 20,
        margin: { top: pdf.autoTable.previous.finalY + 20 },
        tableLineColor: [0, 0, 0],
        tableLineWidth: 0.2,
        styles: { cellWidth: 'wrap', cellPadding: 2, border: '1', halign: 'left' },
      });

      // Save the PDF with the specified filename
      const fileName = `WIT-${this.selectedEmployee.nama.replace(/\s+/g, '_')}.pdf`;
      pdf.save(fileName);
    },
  },
};
</script>

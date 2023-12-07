<template>
  <h1>Inventory List</h1>
  <div class="d-flex flex-row mb-3 ">
    <div class="p-2">
      <button type="button" class="btn btn-secondary">Dowload as PDF</button>
    </div>

    <div class="p-2 ms-auto">
      <div class="input-group flex-nowrap">
        <span class="input-group-text" id="addon-wrapping"><i class="fas fa-search" aria-hidden="true"></i></span>
        <input v-model="searchText" @input="filterItems" type="text" class="form-control" placeholder="Search..."
          aria-label="Username" aria-describedby="addon-wrapping" />
      </div>
    </div>
    <div class="p-2 me-5">
      <button type="button" class="btn btn-success" @click="redirectToAddPage">Add Data</button>
    </div>
  </div>

  <div class="">
    <table id="example" class="table table-striped text-center">
      <thead>
        <tr>
          <th class="text-uppercase">Gambar</th>
          <th class="text-uppercase">Nama</th>
          <th class="text-uppercase">Merk</th>
          <th class="text-uppercase">Harga</th>
          <th class="text-uppercase">Deskripsi</th>
          <th class="text-uppercase">Kategori</th>
          <th class="text-uppercase">Action</th>
        </tr>
      </thead>
      <tbody>
        <tr v-for="item in filteredItems" :key="item.kode_aset">
          <td>{{ item.img_url }}</td>
          <td>{{ item.nama }}</td>
          <td>{{ item.merk }}</td>
          <td>{{ formatRupiah(item.harga) }}</td>
          <td>{{ item.deskripsi }}</td>
          <td>{{ item.Category?.nama }}</td>
          <td>
            <button type="button" class="btn btn-warning" @click="redirectToEditPage(item.kode_aset)">Edit</button>
            <button type="button" class="btn btn-danger ms-2" @click="deleteItem(item.kode_aset)">Delete</button>
            <button type="button" class="btn btn-secondary ms-2" data-bs-toggle="modal" data-bs-target="#staticBackdrop"
              @click="showDetailModal(item)">
              Detail
            </button>

            <!-- Modal -->
            <div class="modal fade" id="staticBackdrop" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1"
              aria-labelledby="staticBackdropLabel" aria-hidden="true">
              <div class="modal-dialog modal-dialog-scrollable modal-xl">
                <div class="modal-content">
                  <div class="modal-header">
                    <h1 class="modal-title fs-5 m-auto" id="staticBackdropLabel">Data {{ selectedItem.nama }}</h1>
                  </div>
                  <div class="modal-body">
                    <table class="table table-striped table-hover">
                      <tbody>
                        <tr>
                          <td class="text-center align-middle" rowspan="6"> IMAGE </td>
                          <th class="text-uppercase text-start" scope="row">Kode Aset</th>
                          <th class="text-uppercase text-start" scope="row">Nama</th>
                          <th class="text-uppercase text-start">Merk</th>
                          <th class="text-uppercase text-start">Deskripsi</th>
                          <th class="text-uppercase text-start">Kategori</th>

                        </tr>

                        <tr>
                          <td class="text-start">{{ selectedItem.kode_aset }}</td>
                          <td class="text-start">{{ selectedItem.nama }}</td>
                          <td class="text-start">{{ selectedItem.merk }}</td>
                          <td class="text-start">{{ selectedItem.deskripsi }}</td>
                          <td class="text-start">{{ selectedItem.Category?.nama }}</td>

                        </tr>

                        <tr>
                        </tr>

                        <tr>
                          <td colspan="8" class="invisible">.</td>
                        </tr>

                        <tr class="mt-2">
                          <th class="text-uppercase text-start">Tanggal</th>
                          <th class="text-uppercase text-start">Masa Manfaat</th>
                          <th class="text-uppercase text-start">Depresiasi</th>
                          <th class="text-uppercase text-start">Harga</th>
                          <th class="text-uppercase text-start">Nilai Residu</th>
                        </tr>

                        <tr>
                          <td class="text-start">{{ selectedItem.tanggal }}</td>
                          <td class="text-start">{{ selectedItem.masa_manfaat }}</td>
                          <td class="text-start">{{ selectedItem.depresiasi }}</td>
                          <td class="text-start">{{ selectedItem.harga }}</td>
                          <td class="text-start">{{ selectedItem.nilai_residu }}</td>
                        </tr>

                        <tr>
                        </tr>

                        <tr>
                          <td class="text-center align-middle" rowspan="3"> STATUS / {{ selectedItem.status }}</td>
                          <td colspan="8" class="invisible">.</td>
                        </tr>

                        <tr>
                          <th class="text-uppercase text-start">Tahun 1</th>
                          <th class="text-uppercase text-start">Tahun 2</th>
                          <th class="text-uppercase text-start">Tahun 3</th>
                          <th class="text-uppercase text-start">Tahun 4</th>
                          <th class="text-uppercase text-start">Vendor</th>
                        </tr>

                        <tr>
                          <td class="text-start">{{ selectedItem.tahun_1 }}</td>
                          <td class="text-start">{{ selectedItem.tahun_2 }}</td>
                          <td class="text-start">{{ selectedItem.tahun_3 }}</td>
                          <td class="text-start">{{ selectedItem.tahun_4 }}</td>
                          <td class="text-start">{{ selectedItem.vendor }}</td>
                        </tr>
                      </tbody>
                    </table>
                  </div>
                  <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                  </div>
                </div>
              </div>
            </div>
          </td>
        </tr>
      </tbody>
    </table>
  </div>
</template>

<script>
import axios from 'axios';
import router from '../router';

export default {
  data() {
    return {
      items: [],
      selectedItem: {},
      searchText: '',

    };
  },
  computed: {
    filteredItems() {
      return this.items.filter(item =>
        this.searchItem(item, this.searchText.toLowerCase())
      );
    },
  },
  mounted() {
    this.fetchItems();
  },

  methods: {
    fetchItems() {
      axios.get('http://localhost:8080/api/inventories')
        .then(response => {
          this.items = response.data.inventory;
          this.filterItems();

        })
        .catch(error => {
          console.error('Error fetching items:', error);
          alert('Failed to fetch items. Please try again later.');
        });
    },
    searchItem(item, searchText) {
      return Object.values(item).some(
        value => value && value.toString().toLowerCase().includes(searchText)
      );
    },
    deleteItem(itemId) {
      if (confirm('Are you sure you want to delete this item?')) {
        axios.delete(`http://localhost:8080/api/inventories/${itemId}`)
          .then(() => {
            alert('Item successfully deleted.');
            this.fetchItems();
          })
          .catch(error => {
            console.error('Error deleting item:', error);
            alert('Failed to delete item.');
          });
      }
    },
    redirectToAddPage() {
      window.location.href = 'http://localhost:8081/InventoryADD';
    },
    redirectToEditPage(itemId) {
      router.push({ path: `/inventory/${itemId}` });
    },
    formatRupiah(angka) {
      var reverse = angka.toString().split('').reverse().join(''),
        ribuan = reverse.match(/\d{1,3}/g);
      ribuan = ribuan.join('.').split('').reverse().join('');
      return 'Rp. ' + ribuan;
    },
    showDetailModal(item) {
      this.selectedItem = item;
      // eslint-disable-next-line no-undef
      $('#staticBackdrop').modal('show');
    },
    filterItems() {
      // This method will be called when the search text changes
      // and will update the computed property `filteredItems`.
    },
  },
};
</script>

<style></style>
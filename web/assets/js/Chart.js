document.addEventListener("DOMContentLoaded", function () {
    fetch('/BankingSystem/FinancialChartServlet')
        .then(response => response.json())
        .then(data => {
            const ctx = document.getElementById('assetChart').getContext('2d');
            new Chart(ctx, {
                type: 'doughnut',
                data: {
                    labels: data.labels,
                    datasets: [{
                        data: data.values,
                        backgroundColor: ['blue', 'cyan', 'purple', 'yellow'],
                        hoverOffset: 10
                    }]
                },
                options: {
                    responsive: true, 
                            maintainAspectRatio: true,  // Đảm bảo biểu đồ thay đổi kích thước khi thay đổi kích thước của phần tử cha

                    plugins: {
                        legend: {
                            position: 'right', // Đặt legend ở bên phải biểu đồ
                            labels: {
                                boxWidth: 10,  // Kích thước của hộp màu trong legend
                                padding: 20     // Khoảng cách giữa các mục trong legend
                            }
                        },
                        tooltip: {
                            callbacks: {
                                label: function (tooltipItem) {
                                    return `${tooltipItem.label}: ${tooltipItem.raw}%`; // Hiển thị % trên tooltip
                                }
                            }
                        }
                    },
                    layout: {
                        padding: {
                            left: 20,    // Padding trái giữa biểu đồ và legend
                            right: 20,   // Padding phải giữa biểu đồ và legend
                            top: 20,     // Padding trên cùng giữa biểu đồ và các thành phần khác
                            bottom: 20   // Padding dưới cùng nếu cần thiết
                        }
                    }
                }
            });
        })
        .catch(error => {
            console.error('Error fetching data:', error);
        });
});

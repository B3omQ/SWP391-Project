document.addEventListener("DOMContentLoaded", function () {
    fetch('/BankingSystem/FinancialChartServlet')
        .then(response => response.json())
        .then(data => {
            const ctx = document.getElementById('assetChart').getContext('2d');
            const totalBalance = data.walletBalance.toLocaleString() + " VNĐ"; // Hiển thị tổng tiền

            new Chart(ctx, {
                type: 'doughnut',
                data: {
                    labels: data.labels,
                    datasets: [{
                        data: data.values,
                        backgroundColor: ['#007bff', '#17a2b8', '#6f42c1', '#ffc107'], // Màu sắc đẹp hơn
                        hoverOffset: 10
                    }]
                },
                options: {
                    responsive: true, 
                    maintainAspectRatio: true,
                    plugins: {
                        legend: {
                            position: 'right',
                            labels: {
                                font: {
                                    family: 'Poppins, Arial, sans-serif', // Font chữ đẹp hơn
                                    size: 12 // Giảm kích thước chữ
                                },
                                color: '#333', // Màu chữ tối hơn cho dễ đọc
                                boxWidth: 12,
                                padding: 15
                            }
                        },
                        tooltip: {
                            callbacks: {
                                label: function (tooltipItem) {
                                    return `${tooltipItem.label}: ${tooltipItem.raw}%`;
                                }
                            }
                        }
                    },
                    layout: {
                        padding: 20
                    },
                    cutout: '70%' // Tạo khoảng trống giữa vòng tròn
                }
            });

            // Hiển thị số dư giữa biểu đồ với font đẹp và nhỏ hơn
            const chartCenter = document.getElementById("chart-center");
            chartCenter.innerHTML = totalBalance;
            chartCenter.style.fontFamily = "Poppins, Arial, sans-serif"; // Font chữ
            chartCenter.style.fontSize = "16px"; // Chữ nhỏ hơn
            chartCenter.style.fontWeight = "bold"; // Chữ đậm hơn
            chartCenter.style.color = "#333"; // Màu tối hơn cho dễ nhìn
        })
        .catch(error => {
            console.error('Error fetching data:', error);
        });
});

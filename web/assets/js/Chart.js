document.addEventListener("DOMContentLoaded", function () {
    fetch('/BankingSystem/FinancialChartServlet')
        .then(response => response.json())
        .then(data => {
            const ctx = document.getElementById('assetChart').getContext('2d');
            // Hiển thị tổng tiền (wallet + saving + loan) ở giữa
            const totalBalance = data.totalWithoutInvestment.toLocaleString() + " VNĐ";

            new Chart(ctx, {
                type: 'doughnut',
                data: {
                    labels: data.labels,
                    datasets: [{
                        data: data.values,
                        backgroundColor: [
                            '#1a73e8', // Màu xanh dương dịu hơn cho Tài khoản
                            '#26c6da', // Màu xanh lam nhẹ cho Tiết kiệm
                            '#8e24aa', // Màu tím đậm hơn cho Đầu tư
                            '#fb8c00'  // Màu cam nhẹ cho Vay
                        ],
                        hoverOffset: 15, // Tăng hiệu ứng hover cho đẹp
                        borderWidth: 1, // Thêm viền nhẹ giữa các phần
                        borderColor: '#ffffff' // Viền màu trắng để phân cách
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
                                    family: 'Roboto, Arial, sans-serif', // Font chữ hiện đại hơn
                                    size: 11 // Giảm kích thước chữ để tránh tràn
                                },
                                color: '#444', // Màu chữ đậm hơn, dễ đọc
                                boxWidth: 10, // Giảm kích thước hộp màu
                                padding: 20, // Tăng khoảng cách giữa các mục trong legend
                                usePointStyle: true // Dùng kiểu điểm tròn thay vì hộp
                            }
                        },
                        tooltip: {
                            backgroundColor: 'rgba(0, 0, 0, 0.8)', // Nền tooltip tối hơn
                            titleFont: {
                                family: 'Roboto, Arial, sans-serif',
                                size: 12
                            },
                            bodyFont: {
                                family: 'Roboto, Arial, sans-serif',
                                size: 11
                            },
                            callbacks: {
                                label: function (tooltipItem) {
                                    const amount = data.amounts[tooltipItem.dataIndex];
                                    return `${tooltipItem.label}: ${amount.toLocaleString()} VNĐ`;
                                }
                            }
                        }
                    },
                    layout: {
                        padding: 30 // Tăng khoảng cách xung quanh biểu đồ
                    },
                    cutout: '75%' // Tăng khoảng trống giữa vòng tròn để đẹp hơn
                }
            });

            // Hiển thị số dư giữa biểu đồ
            const chartCenter = document.getElementById("chart-center");
            chartCenter.innerHTML = totalBalance;
            chartCenter.style.fontFamily = "Roboto, Arial, sans-serif";
            chartCenter.style.fontSize = "14px"; // Giảm kích thước chữ ở giữa
            chartCenter.style.fontWeight = "600"; // Chữ đậm vừa phải
            chartCenter.style.color = "#333";
        })
        .catch(error => {
            console.error('Error fetching data:', error);
        });
});
import { LineChart, Line, XAxis, YAxis, Tooltip, CartesianGrid, ResponsiveContainer } from "recharts"

const data = [
  { month: "Jan", income: 12000, expense: 5000 },
  { month: "Feb", income: 14000, expense: 6000 },
  { month: "Mar", income: 13000, expense: 7000 }
]

export default function Dashboard() {
  return (
    <div className="p-4">
      <h2 className="text-xl font-bold mb-4">📈 Income vs Expense</h2>
      <ResponsiveContainer width="100%" height={300}>
        <LineChart data={data}>
          <XAxis dataKey="month" />
          <YAxis />
          <Tooltip />
          <CartesianGrid strokeDasharray="3 3" />
          <Line type="monotone" dataKey="income" stroke="#22c55e" />
          <Line type="monotone" dataKey="expense" stroke="#ef4444" />
        </LineChart>
      </ResponsiveContainer>
    </div>
  )
}

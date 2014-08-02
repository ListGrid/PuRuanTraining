using KS201008.BusinessLogic;
using NUnit.Framework;

namespace KS201008.UnitTests
{
    [TestFixture]
    public class TestOrderLine
    {
        [Test]
        public void PriceQuantityChange()
        {
            OrderLine line1 = new OrderLine();
            line1.LineID = 1;
            line1.Quantity = 10;
            line1.Price = 8.0M;
            Assert.AreEqual(80, line1.LineTotal);

            line1.LineTotal = 200m;
            Assert.AreEqual(20, line1.Price);

            OrderLine line2 = new OrderLine();
            line2.LineID = 2;
            line2.Quantity = 5;
            line2.Price = 1.1m;
            Assert.AreEqual(5.5, line2.LineTotal);

            Order order = new Order();
            order.Lines.Add(line1);
            order.Lines.Add(line2);
            Assert.AreEqual(200 + 5.5, order.DocTotal);

           
        }
    }
}
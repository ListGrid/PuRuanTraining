using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;

// should use ObservableCollection provided by .NET 3.5
namespace KS201008.BusinessLogic
{
    
    /*
    public class ObservableCollection<T> : System.Collections.Generic.List<T>
    {
        public event ItemAddedEventHandler ItemAdded;
        public delegate void ItemAddedEventHandler(T o);
        public event ItemRemovedEventHandler ItemRemoved;
        public delegate void ItemRemovedEventHandler(T o);

        public new void Add(T Value)
        {
            base.Add(Value);
            if (ItemAdded != null)
            {
                ItemAdded(Value);
            }
        }

        public new void Remove(T Value)
        {
            base.Remove(Value);
            if (ItemRemoved != null)
            {
                ItemRemoved(Value);
            }
        }

    }
    */
}

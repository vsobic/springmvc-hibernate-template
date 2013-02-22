package org.springsource.examples.spring31.web;

import java.nio.charset.Charset;
import java.util.Collection;
import java.util.Date;
import java.util.List;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springsource.examples.spring31.services.Customer;
import org.springsource.examples.spring31.services.CustomerService;

//
//@RequestMapping(
//        //consumes = MediaType.APPLICATION_JSON_VALUE,
//        produces = MediaType.APPLICATION_JSON_VALUE)
@Controller
public class CustomerApiController {

    private Logger log = Logger.getLogger(getClass());

    @Autowired
    private CustomerService customerService;

    @ResponseBody
    @RequestMapping(value = "/crm/search", method = RequestMethod.GET)
    public Collection<Customer> search(@RequestParam("q") String query) throws Exception {
        query = reEncode(query);
        Collection<Customer> customers = customerService.search(query);
        if (log.isDebugEnabled())
            log.debug(String.format("retrieved %s results for search query '%s'", Integer.toString(customers.size()), query));
        return customers;
    }

    private String reEncode( String input ) {
        Charset w1252 = Charset.forName("Windows-1252"); //Superset of ISO-8859-1
        Charset utf8 = Charset.forName("UTF-8");
        return new String(input.getBytes(w1252), utf8 );
    }

    @ResponseBody
    @RequestMapping(value = "/crm/customer/{id}", method = RequestMethod.GET)
    public Customer customerById(@PathVariable("id") Integer id) {
        return this.customerService.getCustomerById(id);
    }

    // http://springmvc31.joshlong.micro/crm/customers
    @ResponseBody
    @RequestMapping(value = "/crm/customers", method = RequestMethod.GET)
    public List<Customer> customers() {
        return this.customerService.getAllCustomers();
    }

    // http://springmvc31.joshlong.micro/crm/customers
    @ResponseBody
    @RequestMapping(value = "/crm/customers", method = RequestMethod.PUT)
    public Integer addCustomer(@RequestParam("firstName") String fn, @RequestParam("lastName") String ln) {
        return customerService.createCustomer(fn, ln, new Date()).getId();
    }


    @ResponseBody
    @RequestMapping(value = "/crm/customer/{id}", method = RequestMethod.POST)
    public Integer updateCustomer(@PathVariable("id") Integer id, @RequestBody Customer customer) {
        customerService.updateCustomer(id, customer.getFirstName(), customer.getLastName(), customer.getSignupDate());
        return id;
    }

/*    @ResponseBody
    @RequestMapping(value = "/customer/{id}", method = RequestMethod.DELETE, produces = MediaType.APPLICATION_JSON_VALUE)
    public Integer deleteCustomer(@PathVariable("id") Integer id) {
        customerService.deleteCustomer(id);
        return id;
    }*/

}             

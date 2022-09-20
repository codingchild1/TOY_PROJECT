package com.controller;

import com.service.SubPageSerivce;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("rest")
public class LoginRestController {

    @Autowired
    SubPageSerivce subPageSerivce;

    /**
     *
     * @param mberId
     * @return
     * @throws Exception
     */

    @RequestMapping("memidoverlap")
    public String memidoverlap(@RequestParam(value="mberId") String mberId) throws Exception {
        boolean overlap = false;
        try {
            overlap = subPageSerivce.memoverlap(mberId);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return String.valueOf(overlap);
    }
}

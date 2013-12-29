package phonelibv2



import org.junit.*
import grails.test.mixin.*

@TestFor(ShiroUserController)
@Mock(ShiroUser)
class ShiroUserControllerTests {


    def populateValidParams(params) {
      assert params != null
      // TODO: Populate valid properties like...
      //params["name"] = 'someValidName'
    }

    void testIndex() {
        controller.index()
        assert "/shiroUser/list" == response.redirectedUrl
    }

    void testList() {

        def model = controller.list()

        assert model.shiroUserInstanceList.size() == 0
        assert model.shiroUserInstanceTotal == 0
    }

    void testCreate() {
       def model = controller.create()

       assert model.shiroUserInstance != null
    }

    void testSave() {
        controller.save()

        assert model.shiroUserInstance != null
        assert view == '/shiroUser/create'

        response.reset()

        populateValidParams(params)
        controller.save()

        assert response.redirectedUrl == '/shiroUser/show/1'
        assert controller.flash.message != null
        assert ShiroUser.count() == 1
    }

    void testShow() {
        controller.show()

        assert flash.message != null
        assert response.redirectedUrl == '/shiroUser/list'


        populateValidParams(params)
        def shiroUser = new ShiroUser(params)

        assert shiroUser.save() != null

        params.id = shiroUser.id

        def model = controller.show()

        assert model.shiroUserInstance == shiroUser
    }

    void testEdit() {
        controller.edit()

        assert flash.message != null
        assert response.redirectedUrl == '/shiroUser/list'


        populateValidParams(params)
        def shiroUser = new ShiroUser(params)

        assert shiroUser.save() != null

        params.id = shiroUser.id

        def model = controller.edit()

        assert model.shiroUserInstance == shiroUser
    }

    void testUpdate() {
        controller.update()

        assert flash.message != null
        assert response.redirectedUrl == '/shiroUser/list'

        response.reset()


        populateValidParams(params)
        def shiroUser = new ShiroUser(params)

        assert shiroUser.save() != null

        // test invalid parameters in update
        params.id = shiroUser.id
        //TODO: add invalid values to params object

        controller.update()

        assert view == "/shiroUser/edit"
        assert model.shiroUserInstance != null

        shiroUser.clearErrors()

        populateValidParams(params)
        controller.update()

        assert response.redirectedUrl == "/shiroUser/show/$shiroUser.id"
        assert flash.message != null

        //test outdated version number
        response.reset()
        shiroUser.clearErrors()

        populateValidParams(params)
        params.id = shiroUser.id
        params.version = -1
        controller.update()

        assert view == "/shiroUser/edit"
        assert model.shiroUserInstance != null
        assert model.shiroUserInstance.errors.getFieldError('version')
        assert flash.message != null
    }

    void testDelete() {
        controller.delete()
        assert flash.message != null
        assert response.redirectedUrl == '/shiroUser/list'

        response.reset()

        populateValidParams(params)
        def shiroUser = new ShiroUser(params)

        assert shiroUser.save() != null
        assert ShiroUser.count() == 1

        params.id = shiroUser.id

        controller.delete()

        assert ShiroUser.count() == 0
        assert ShiroUser.get(shiroUser.id) == null
        assert response.redirectedUrl == '/shiroUser/list'
    }
}
